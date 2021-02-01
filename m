Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B2630A56C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 11:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhBAKdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 05:33:02 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:29456 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233183AbhBAKc7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1612175511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+M7Q1CnqP86CHAkLEEHGEGXuEq0C2Ximm+9ASMR5Yg=;
        b=hRGSYoPi7V6kJ82LAj4WlNk+wX4L/cNLQM4ySy+fpy0zNyMlBAYYo6eTAhh+086ZhF2D6m
        k5DPVPCpfPD++aZZbl3Ui1UFuLm8gGjrWZ/0aoOA94rRFASSaoIWTT6zp61WRoaAOgflDn
        1EmBVj0aaf8QQZ9TxclJqkzCnC1ZmHQ=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2054.outbound.protection.outlook.com [104.47.9.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-a8ilU4f6Nz-kaQhy7GgBDw-1; Mon, 01 Feb 2021 11:31:50 +0100
X-MC-Unique: a8ilU4f6Nz-kaQhy7GgBDw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSxrJs6D/6mj6HbkQxeEzjoTJY1hwXBP/SN8gj4ia08AdA2UGV+qUw1wqUWN9UaNMXyFKlNENaFZFg9IE63w+DO5/ZZKAwx4K2zSMe5FQQzHPN8LszOg1IxWLJT3G665/QmeZVQYprAC8qIaq1Knv6vhpDFbzcSb+1onldqQg8tvzmMHOMtbX6Oh3xoYrrAyQrl2Ij1UWHnCGL31DkGceu4PO6oPGgN3NdrGP+FmbJWsYX9L+K53wIPCZ0a6prBumke3gqqFxWVCTgbWAP+uCLHQCPqF+Dn4YOBOVSEo97+GDuF+iEo/OEgV9oZek0XoldyVZv7mUxX2kVlxCLQI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+M7Q1CnqP86CHAkLEEHGEGXuEq0C2Ximm+9ASMR5Yg=;
 b=CbrMk/KTiWmxWHn9ko3lS8uY4SO1/cLSNYuSyLYMWxplZpS0aHF49oo3paA32QP6/SxN53CeUudSdbZW6xfOvP8ZrRmMg/VWLSu73Whtna0xoy3ULqyNky0XOD5Qb2S8wwedOHqRzjVz1qnV4/2hQINBt6qJi/OZXEMtXpmCQQ4Le5Gqn70XjV1AXXjRBofiiPlPRpNUgj+8rketMKtdMnrbs0NNIqSVXVT9lx8202LAgjuB+zMVTisffQ+fMwhdh/nf7Dvm92zkqVKusCBuhuJdbg4lIx6nD63JD03kAf8xvK7hvTo62yD6EJSWc0a87rS/rsR6Avbm3t2tZGaoFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB5920.eurprd04.prod.outlook.com (2603:10a6:803:ed::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 10:31:48 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3805.022; Mon, 1 Feb 2021
 10:31:48 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>, Paulo Alcantara <pc@cjr.nz>
Subject: Re: [PATCH v1] cifs: make nested cifs mount point dentries always
 valid to deal with signaled 'df'
In-Reply-To: <CANT5p=ofvpimU9Z7jwj4cPXXa1E4KkcijYrxbVKQZf5JDiR-1g@mail.gmail.com>
References: <20210129171316.13160-1-aaptel@suse.com>
 <CANT5p=ofvpimU9Z7jwj4cPXXa1E4KkcijYrxbVKQZf5JDiR-1g@mail.gmail.com>
Date:   Mon, 01 Feb 2021 11:31:45 +0100
Message-ID: <877dns9izy.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:705:9f12:fb7a:e8aa:e796:34d1]
X-ClientProxiedBy: GV0P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::7) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:9f12:fb7a:e8aa:e796:34d1) by GV0P278CA0020.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Mon, 1 Feb 2021 10:31:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b80d334-8cbf-4aae-8850-08d8c69c9471
X-MS-TrafficTypeDiagnostic: VI1PR04MB5920:
X-Microsoft-Antispam-PRVS: <VI1PR04MB59207875CD187A8ADCA87A51A8B69@VI1PR04MB5920.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbbSQUTvSCFVY5gh9wr12qUc+tjkkHwCjyhI0pEp5ztEW/bZsqtSQw8mP/g7gKDDBkzeZymdm4xfQw2XeFQP/wVXUB1rpf+kwxQgzeFYanXBJrhZudSQecWnrOUo9A4MPXV35QgCYRMTqJl3fs5GU2eo7X7APwXDDjVD5ncv5hiJrx/2jHVLnqBJ0Gut9SPcx61K2Efx8sZqcMUhL24tXjEwTrc06K3CKw13NIXj+qawZR8Z67vuSYdPPq53gbBXRH4O9/0zKCjGOp6ZsU8C/EeJV5TJFaxJRDEcJWWJ4t6pWJ8NoLggq+4ZAik1CwhIhmSUaiLgqFzRgBujrTGYH4In35EPM/phUeLMLJy2L6LUa+WJb3HdfQV+QDe86XzYRX9d2hvDOwJ4wQ8JMYZBV4hpAvQ282E5bNMlm7VEypJ+SBlLInwEf6/jU1vnd/siJRhAKV+va9rjJtosIFeuePyW/J52Nv92jWQsWZgS/m0kT+wbjcj551rZ6xedCjQGYxpbRejt3Sbx+cYKg+CVew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(376002)(39860400002)(54906003)(2906002)(8936002)(6916009)(2616005)(36756003)(6496006)(52116002)(4326008)(8676002)(316002)(66556008)(66476007)(66946007)(86362001)(5660300002)(6486002)(16526019)(186003)(478600001)(83380400001)(66574015)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MUlmY293WG1iQ3pkUzhaaGhtRFZDY1NJK3c5T3R2MWxPZWJYNGVGb0djOW1N?=
 =?utf-8?B?R3VSbmp6SklzaEFhVG5melRTeTA2YU44MUg4OXpSdERtbGpMakI1QmJqVWRF?=
 =?utf-8?B?NWRQb25uQ2NxakRmMEZpNS9vM3NDUWlOb1BHL3p2MUIvRHdWdW1jWGJzU3lI?=
 =?utf-8?B?a21uN3FJeTBuQVhROHhIeENGcko5d1NEd0RqdkUwOUxaNEhRdmVpUEZFeURI?=
 =?utf-8?B?a2ZYQlg4WGp4Qm5ocTFYbXBVbDk1eGp1RzNRa1RQenFFNDBSd3JqdDV3elZ6?=
 =?utf-8?B?Qzl4MWRIL2NHODN5SlRYUURUMDMwSXJjSS9ONDhwdittMUdsZTlWcjlld1Rk?=
 =?utf-8?B?YnRSNEVhRnZ6MVNxaUpsZW85ZGJhMzJzbW0vdU5MZ3JsMWdybTdNSmwxaGx3?=
 =?utf-8?B?UHpGQUxmRDNveHBLM0crSHNzTlBxd0hIWG5PWnY3b2I2cWRDUW5MdjdhOExH?=
 =?utf-8?B?ZzR0T0Y5T2NzMXN3eFd6UXBTL2UzK3lRcWphd3F1NGRRUTJUalRIWkwveUp2?=
 =?utf-8?B?Z2tST28xYlB3dXA1ZmhvWFNPZXNuRDFYNTRaQWFoTmsySXI1QysvUUhabFZP?=
 =?utf-8?B?WVNmVERMcld4MStMeTl4VVZsNXNUSU0yL0xMMXVZY0NSai82bk0zZXZuNDRQ?=
 =?utf-8?B?SFpYa0Nib2lEUzFuVVFBSFhKQmFCcVRhY2hlZ205eFlVMXhuUFVGVzcvQUMv?=
 =?utf-8?B?WDlLU2dORTEwbTRmQnBoaHZIWnYzQnREZ0ltODhwWmdjVHJuUVlTeUlOUkhw?=
 =?utf-8?B?TDlnMllyU2svUkFpaWVzN3VYaVJWLytrOStsL0tSYklwU29tQWYxUC9nWHFm?=
 =?utf-8?B?Rlp6V1RIYVUxWnVvYzdNS0hIQTRHU1NpYlBrMjJvZTFMc3BuNXNkeTRYTG5W?=
 =?utf-8?B?UklkTGlyNHB0Nlhtb01RREtiZWZiZWZ4eGlDd3l2Z29XRmhCZGxrbVlORWg4?=
 =?utf-8?B?MGluQllGUTlvcWtxeUZFaEgzT3hoVmU3NnBjTnN4OTNXdkVxcytadjdkeWtP?=
 =?utf-8?B?azNySzhuWHNxMWczaVpBaUcxTmlLa2MxdkN5UTl3UTBEUVllZFV4M2ZpQ1Zh?=
 =?utf-8?B?Vk95b3M3NWVZSDZ1Q2YzVW9jbU9ZU0hKVVhHcTZtSkIwcWJGZDJ0eCtTTXhH?=
 =?utf-8?B?L1ltM3RYVkh6b1d0YitHL2JlalVvODdCRFFPMDlXV2dEekl6WklkUDVMdVNE?=
 =?utf-8?B?cmpZMVA0bVlaWC9TaGhCREVGbm5qVVA5UnBETFJQcFZ5djFpRGwrVElUR1p3?=
 =?utf-8?B?MGFmbXQ5WE1FUkgyblpOcTZkY0U3TlpHNTBjMFlJN2F4Z0tCUTVlQk5XZmor?=
 =?utf-8?B?ampQNVFWa1oyRFlFV0k4enRNMmVlOUZFUEs3MnkvLzVSV293THd2akxVTS9z?=
 =?utf-8?B?WGFYMVRTUmxHTmVKbzhWczFESEovQVFZQW9aalpPcmNZVzZISmF3RWtIZEtW?=
 =?utf-8?B?U281ZFJ2cFRtclVRd1JKajZtQTV2ZitwR1NnV2lrZ0t5MnFoZW91QURvRG4v?=
 =?utf-8?Q?dtyyvZZ50BXYWQIKYlRPIhWYo3W?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b80d334-8cbf-4aae-8850-08d8c69c9471
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 10:31:48.2340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAXAk0rSwzmaz4Dg5z3gOeypmIGsGd9C96dUThBkcTXa8ou/bPdc29BMeAbVzYBI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5920
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shyam Prasad N <nspmangalore@gmail.com> writes:
> Going by the documentation of d_revalidate:
>> This function should return a positive value if the dentry is still
>> valid, and zero or a negative error code if it isn't.
>
> In case of error, can we try returning the rc itself (rather than 0),
> and see if VFS avoids a dentry put?
> Because theoretically, the call execution has failed, and the dentry
> is not found to be invalid.

AFAIK mount points are pinned, you cannot rm or mv them so it seems we
could make them always valid. I don't know if there are deeper and more
subtle implications.

The recent signal fixes are not fixing this issue.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

