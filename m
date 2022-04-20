Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B036A507E2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 03:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358720AbiDTBaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 21:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346200AbiDTBae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:30:34 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com (esa9.fujitsucc.c3s2.iphmx.com [68.232.159.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF08245A2;
        Tue, 19 Apr 2022 18:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650418070; x=1681954070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fGvdzhGdKopQh1a7OYLriTI1e3NOhITqSKG3ZAB2tsc=;
  b=doyjcPYP9SCAsoieHtOY4XU5WPhpL88A9e1IWqZpwsHiNkeVRR8bMTgL
   X6YHPHRteeBvYtHQFNMJVRJwgs8ergQgzRj7Xx4HiyBFtNbLYu3gxwR5X
   28fe6QCJW40fXcotzDY2ySaM5T891iOUtSkxMPktQW37sqVBszAzKqJD6
   4hCA5A5xICx8v4AiW6ql2nLbacW6PerVABwD3FD6gXjE05vTcyuCU6ZAj
   PkeMGoqQF27YW08IXYsFyfVERY1HXCpUQj/XJbxrk67lEYJsTHm9Leyiu
   IgLLH+dUqH9OpBpvWnjMv0ytcO2rNRrZf1miUj1JpdI1FqCbiOrEE3BpN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="54387674"
X-IronPort-AV: E=Sophos;i="5.90,274,1643641200"; 
   d="scan'208";a="54387674"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 10:27:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBQwRxfUuc7x9ASDjYEPXrt8K/JHPZ6zVJrEH9tnEBxzlMd/KXWrlwDcPtqKqWcVMZMw/i3KgIg3hwv6nLRgAijTVQS1UAUFHxC6Q0HV36U6aQbloWmJ7j3hQqwoEdDSWhmFfB48p4BedGzks9fKAUAjPOJvce6b1GA46izt8PeZnCVuqCbQh7eHJK2ES9a+SOtIjHH5w6+Zmt2eHXUZ+CqpJcqQzyZYi69KRQ7kkF2FikBD1F7jASHcpYrdrYE70ydRxJOScSACp7aCMVeF12/z84ubGhAFPMwMwkV/PkuEiaeWRcAfddFlbVIS7LpxpsXDtgJIFnFP8hsb5ywxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGvdzhGdKopQh1a7OYLriTI1e3NOhITqSKG3ZAB2tsc=;
 b=Bx4fm1m87LV1tYROUy6D/m0yPKi3KwkOBCGPJOX7hZMIUzfJkI0hhv5Mf62xHBA1ubyEBPKkDleZPJZxZcxei4KAb/18+KOm48eIKt0GKyfJHqxA5XaI8BYxd7jn/wDKpAhHTIEpeZ+55JyCX/NwgBaZF/iTaRysnSIxFMbo1xgdyRwT1dYqYGV0MBZYiqhXxRz4sLPsOwj1cffdapXALCrK14xVcLTp0fYONDSoVujvM8IA0Ca2mI67VY7PQCAKUF+A2rV5xAaJ3iS1caa+1/jVDXwenL9WzvbY+vibOe/hhcAVfswBuUdZ4l5Gi5uQyQnudgGHEvYxHkJ63meQAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGvdzhGdKopQh1a7OYLriTI1e3NOhITqSKG3ZAB2tsc=;
 b=J3hu6ABqgnxq0qmhJ28ppzMHqiJJA+Uh4ISJLS9W+63vr1Nvz4VZ/ez9vlx+i0aJ/SG3xSUtOxW/i8u37bxeUgFcbGjDQbp7pHjanVYMetDQpUrfnJBZnQnYNjz4MYcP+oE5DMs3HMq6hTI6GlMC2ZLsX7McUet4gJN/8CYxDPM=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB2689.jpnprd01.prod.outlook.com (2603:1096:604:1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 01:27:39 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 01:27:39 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH v4 1/8] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Topic: [PATCH v4 1/8] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Index: AQHYU9rGMcoXoXAhFUC0+s6Sqe+NAqz3RT4AgADPzgA=
Date:   Wed, 20 Apr 2022 01:27:39 +0000
Message-ID: <625F6FE6.4010305@fujitsu.com>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220419140508.b6c4uit3u5hmdql4@wittgenstein>
In-Reply-To: <20220419140508.b6c4uit3u5hmdql4@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 435481f6-8261-4f1a-1758-08da226cf575
x-ms-traffictypediagnostic: OSAPR01MB2689:EE_
x-microsoft-antispam-prvs: <OSAPR01MB268903EDE05D2131C76484E5FDF59@OSAPR01MB2689.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+0fD1+GQW1OSEc1HsHRR76qffGIVob8vPsHyR2nHrY2WIcRbOOmYS4z5RuUUgFCMDKoyHc5na2BtSuVLUk2jRuLNDIctHOpAK+6EJsXTXz2T2H0S2+50BjpBENoeyAMdDE0m9uE0tY2SpfQspTmOIH6LYTdpoSEGcjMq9ql8UR0iiJ0CKbc3euuVb+Sj3xZ0YEnuThLS/SiOCxXyB2kra158UWiXVqzFm1gDk3Lr64oUwQLZzJB8GueA3eIMqmU3WhKVIor9rsSTubzO2XwmVT39CpRcvTm0x4h4D7aDvigubgiSrxd/oHFGl+zvdzkYy85OqXKGOUUUoKTJPfz2kDj8GTuYDACrkG3RTXWEKsA5oNpdgJyT9lVHvInMAaZW+QYAlfjCxcvhK8K+SGLaD9zpNDz3he3gp4PtR1X2TUEcQmEObkcNhrwm/i5ck+2cEBrGkl0PCxmOysfQjZ+ZBv1q0KOmSXqllX+G+1MMPn5ehSQxw0P6RsFqcWg9w1EO+fM1Peh13ydsRZt3EI1duNmvpYArzUkgZlaUNCxoVj3hTs+9SHmjEjSVNgtzt119HKqI/iFBmx3Qi4a3ZbvXf4N/OuHRZ4m7fnnu1a165lfFmW16GyMHvNzx6bVKFObV6T+S/kFU6RP3Z6GRuTutVAjpCq9UpWh+dnte5erexIEKWPeJleEitqfRff/dxEREm5Gb1Yq4dyinJbCZAnygw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(26005)(87266011)(4326008)(6506007)(6486002)(5660300002)(508600001)(38100700002)(7416002)(38070700005)(2906002)(8936002)(33656002)(122000001)(45080400002)(186003)(86362001)(6512007)(83380400001)(2616005)(316002)(85182001)(8676002)(54906003)(64756008)(66446008)(91956017)(6916009)(71200400001)(66946007)(76116006)(36756003)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGQ3cVBPY3VSVTFQZjBQME5manl3ZklkZDBJejBKK3AzamxtNGdrQ2xjU2R3?=
 =?utf-8?B?SVVKZ0tVNEZZNHd2M0lpR2ZVUmZRazhGL3VNUncwR0lJQTdlbG9SbStxdG85?=
 =?utf-8?B?WHN4VkxyZmxsczhtTTI0WkQxVnBRcnN3TG1pL0ZmQ3NzbEhwUzdQc3krbkFv?=
 =?utf-8?B?bll6Wk5ENEJvQnZ6M2xNNWZteVlyZUxGZ05GL1RjaXBYeFhqU1dTTHp3UDQ5?=
 =?utf-8?B?OXpPcHZIMEg5YVdvM2M5ZEdGODZleVhpOEVLUktJUkNPSzFtd0JvMnZ1YTJT?=
 =?utf-8?B?ZVZ2Q3RaLzJiWFl1eUlSOG1ZekdCSFJoN3BtZmlnZTgzYmF4S2JVTnBpMVZU?=
 =?utf-8?B?bUQvZmdyNWZ6ejJVTXlySjBneVpBYXBMQlljVC9TU0xTTENZNUxOd1dGL1BT?=
 =?utf-8?B?MFpxcUc4TmVqazdDOGRRQXgzSVdVOXQrQ3FBbDV4OUxyTzdyZzhlc3IySHBD?=
 =?utf-8?B?SmR0UmxLaGhIYmp5anRGcGNNVE5xRENMb1pBS085b2hQcllReXpNellPdFVq?=
 =?utf-8?B?UjN3cTVlV1V0Q2VYWlFhcnBQWU5KTU4yZ3BhanA2Ykt6Sm13RVRVWDhiRHo0?=
 =?utf-8?B?SHBEWmN3YnFLaXdnUUZhdFpZcE1sZW1oZXFSWDkzb1JoSnhka2lIMlByaEVL?=
 =?utf-8?B?dDh4QnpLdHdZVlVlZzJPVGJ6YlJEdGxEdTgzMTNLWEcxYXpSbk9CVDErQ1c3?=
 =?utf-8?B?Y0s0YzR4SWlKeW1jVXpwWHVVcXo2c1JvN1BDNkpFMWZucUxwbXdReDYraGFK?=
 =?utf-8?B?WDNSWldXMzBYczdjWnM0SGFlQWxzMGRRQUVPQ013VlM3OVg2ZmpEYU4zTmNk?=
 =?utf-8?B?WUd0TVlCRUUxRzcyYzdWNktlWkU2ajlvUWtUWUZFZ3FmbGRjNWxCa3hpZStZ?=
 =?utf-8?B?d1NmU09mSFpjazJnODRld1BjVlMyeWdXeEpnOVdKYW9DSWpnNUNoWFp6MjE5?=
 =?utf-8?B?WHdJQ1A5WEpIUnNyYkRZQ05XTEN0akEvbXQwdmJnazVTT00zVUdtL1FqYWl6?=
 =?utf-8?B?OGc0VlVER2FGK1pyZFcydTE2ZCtydTV3NnlkVUhGaUdqbVFmL3FZenhCTEV6?=
 =?utf-8?B?UHcvZDNsVGxrVk13RHZtVWFaQXF0QU1XUVl0ZkNQZ0tkSVIvbmEzK3lpWU5k?=
 =?utf-8?B?NE41YW96RjlGb2gyak1VbFZZanZFZ3FJV0NISnZBdlJlYUV6bjRKN2REVENw?=
 =?utf-8?B?VGFObTdWcDBsbUdORmFOWGVVUk95ODQ3b0JscnZlTDZybVl0bjRNQk5sY0s3?=
 =?utf-8?B?bHprRXZqQ3JKb1lOenJ2YkhpcXUwcDVWeFpmcnFjRlhLR043OG5WNHlrWFNr?=
 =?utf-8?B?czBEdzhPS0lRUFpDVS9MNmtnYjlsTUVLaGYyL0M4Sm5ZZ2dQSVRlVG1uMFg1?=
 =?utf-8?B?WHZCOTBWU1FiT3loNzZDamRXSDhFZFF6NEZGc1h4U3oya3VBOW9KekFiOTF2?=
 =?utf-8?B?S0xwNTU0R0JzekZ4TUJXL2VGTWlkQ0crbWhKN1ZqY1NoVExDMldZNXllSjFz?=
 =?utf-8?B?MjVROVEzTklrcEJJU1hqZk9icGdGVkpIZzAvVDg5Rk1CQW5yUFRtdCtyeFZr?=
 =?utf-8?B?cFJJNlY1LzFQR3N2TnphYXpFNlh3OHFPV2dqblhrSkFmd3grWjc1WVVaR2pk?=
 =?utf-8?B?dVVRTU52bmUyTnVxU2dnV3BldHhOYXE4akFyUzNhT1NOcERIWlZNdkg1SW4w?=
 =?utf-8?B?M1FGaVRJZDVWU2hGd1Fvc2xvSnBITCtxbm5ZSTVyYjVTeWRwenFyZmtCaGwy?=
 =?utf-8?B?TWRsM3Q0YVR2bysxN1U0UDFTeWZNSkx4M29NUzRYMWpCa21ybjE0ZldLa0dD?=
 =?utf-8?B?RTAvZUxxbkVycHFCSW8wcjNZemtpVnJJMXJ3Mm1hekkzYlpjWVpQQ2NqVWpR?=
 =?utf-8?B?bVVZUDFXcmN6NUo2ckFWcFc0TmRUUkRPZW5zRUdUTjkwbktMNjI1Y2paNmo5?=
 =?utf-8?B?KzdqSDVwSEM3MTRZUE9KcnV2ZXBpVVZyRGJrQit4bzJ5YlVNbnZySEJKZXVw?=
 =?utf-8?B?YkZCNDJUTTNpSHZJNDZmZGsyM2dVODBLS2pUSXlFeXJONmduQ044OE9lOTI4?=
 =?utf-8?B?RTNnTmJWZWlTVlI0MEgzVzFmMDd3Vk1lTDA2RTVqQ2xXM3dYcXVWN01iT0Ju?=
 =?utf-8?B?QVQzTmZJMzVzalhLK1ppTUlSTnlJcDZwM0VmUlZzZEFnemZKTm9lK0pFV2dt?=
 =?utf-8?B?a0c0TDA1UStFcUVnN0pZUXBpS0tHT0pKSmJNQmVCQmdHQm5Hczgxdk1IT1RG?=
 =?utf-8?B?TDJJTVJaM3FQZFcrajFtQytGd1lNbHA0TXdwanNZRFE1YnkyelcxVTh6SDRv?=
 =?utf-8?B?TEJGMlFXRFRPZlJ5NHRRRmZsZFAwU3dWTjNoZHl0RzlNZy9xOEl6ZTZxOURu?=
 =?utf-8?Q?cQxMLZPP/LEyoR3InHaurQSq4IKs5ANe4sXET?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BDC29D4A3266544A4D1B5506A11F6AD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435481f6-8261-4f1a-1758-08da226cf575
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 01:27:39.5469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0JqUUgRldlvTuP8/VQ6r9PuDJkz3psCXhuazGIrsdXkPdMcgYvqRYAZw+oRw8EL/3Heza1FbsAgH4bZwHd6L9VSHry4SPtlz5Emzc+5BEpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2689
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzE5IDIyOjA1LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMTksIDIwMjIgYXQgMDc6NDc6MDdQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFRoaXMg
aGFzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlLiBKdXN0IGNyZWF0ZSBhbmQgZXhwb3J0IGlub2RlX3Nn
aWRfc3RyaXAgYXBpIGZvcg0KPj4gdGhlIHN1YnNlcXVlbnQgcGF0Y2guIFRoaXMgZnVuY3Rpb24g
aXMgdXNlZCB0byBzdHJpcCBTX0lTR0lEIG1vZGUgd2hlbiBpbml0DQo+PiBhIG5ldyBpbm9kZS4N
Cj4+DQo+PiBBY2tlZC1ieTogQ2hyaXN0aWFuIEJyYXVuZXIgKE1pY3Jvc29mdCk8YnJhdW5lckBr
ZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1aml0
c3UuY29tPg0KPj4gLS0tDQo+PiAgIGZzL2lub2RlLmMgICAgICAgICB8IDIyICsrKysrKysrKysr
KysrKysrKy0tLS0NCj4+ICAgaW5jbHVkZS9saW51eC9mcy5oIHwgIDMgKystDQo+PiAgIDIgZmls
ZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZnMvaW5vZGUuYyBiL2ZzL2lub2RlLmMNCj4+IGluZGV4IDlkOWI0MjI1MDRkMS4u
MzIxNWU2MWEwMDIxIDEwMDY0NA0KPj4gLS0tIGEvZnMvaW5vZGUuYw0KPj4gKysrIGIvZnMvaW5v
ZGUuYw0KPj4gQEAgLTIyNDYsMTAgKzIyNDYsOCBAQCB2b2lkIGlub2RlX2luaXRfb3duZXIoc3Ry
dWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPj4g
ICAJCS8qIERpcmVjdG9yaWVzIGFyZSBzcGVjaWFsLCBhbmQgYWx3YXlzIGluaGVyaXQgU19JU0dJ
RCAqLw0KPj4gICAJCWlmIChTX0lTRElSKG1vZGUpKQ0KPj4gICAJCQltb2RlIHw9IFNfSVNHSUQ7
DQo+PiAtCQllbHNlIGlmICgobW9kZSYgIChTX0lTR0lEIHwgU19JWEdSUCkpID09IChTX0lTR0lE
IHwgU19JWEdSUCkmJg0KPj4gLQkJCSAhaW5fZ3JvdXBfcChpX2dpZF9pbnRvX21udChtbnRfdXNl
cm5zLCBkaXIpKSYmDQo+PiAtCQkJICFjYXBhYmxlX3dydF9pbm9kZV91aWRnaWQobW50X3VzZXJu
cywgZGlyLCBDQVBfRlNFVElEKSkNCj4+IC0JCQltb2RlJj0gflNfSVNHSUQ7DQo+PiArCQllbHNl
DQo+PiArCQkJaW5vZGVfc2dpZF9zdHJpcChtbnRfdXNlcm5zLCBkaXIsJm1vZGUpOw0KPj4gICAJ
fSBlbHNlDQo+PiAgIAkJaW5vZGVfZnNnaWRfc2V0KGlub2RlLCBtbnRfdXNlcm5zKTsNCj4+ICAg
CWlub2RlLT5pX21vZGUgPSBtb2RlOw0KPj4gQEAgLTI0MDUsMyArMjQwMywxOSBAQCBzdHJ1Y3Qg
dGltZXNwZWM2NCBjdXJyZW50X3RpbWUoc3RydWN0IGlub2RlICppbm9kZSkNCj4+ICAgCXJldHVy
biB0aW1lc3RhbXBfdHJ1bmNhdGUobm93LCBpbm9kZSk7DQo+PiAgIH0NCj4+ICAgRVhQT1JUX1NZ
TUJPTChjdXJyZW50X3RpbWUpOw0KPj4gKw0KPj4gK3ZvaWQgaW5vZGVfc2dpZF9zdHJpcChzdHJ1
Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsDQo+PiArCQkgICAgICBjb25zdCBzdHJ1Y3Qg
aW5vZGUgKmRpciwgdW1vZGVfdCAqbW9kZSkNCj4+ICt7DQo+DQo+IEkgdGhpbmsgd2l0aCBXaWxs
eSBhZ3JlZWluZyBpbiBhbiBlYXJsaWVyIHZlcnNpb24gd2l0aCBtZSBhbmQgeW91DQo+IG5lZWRp
bmcgdG8gcmVzZW5kIGFueXdheSBJJ2Qgc2F5IGhhdmUgdGhpcyByZXR1cm4gdW1vZGVfdCBpbnN0
ZWFkIG9mDQo+IHBhc3NpbmcgYSBwb2ludGVyLg0KDQpJTU8sIEkgYW0gZmluZSB3aXRoIHlvdXIg
YW5kIFdpbGx5IHdheS4gQnV0IEkgbmVlZCBhIHJlYXNvbiBvdGhlcndpc2UNCkkgY2FuJ3QgY29u
dmluY2UgbXlzZWxmIHdoeSBub3QgdXNlIG1vZGUgcG9pbnRlciBkaXJlY3RseS4NCg0KSSBoYXZl
IGFza2VkIHlvdSBhbmQgV2lsbHkgYmVmb3JlIHdoeSByZXR1cm4gdW1vZGVfdCB2YWx1ZSBpcyBi
ZXR0ZXIsIA0Kd2h5IG5vdCBtb2RpZnkgbW9kZSBwb2ludGVyIGRpcmVjdGx5PyBTaW5jZSB3ZSBo
YXZlIHVzZSBtb2RlIGFzIA0KYXJndW1lbnQsIHdoeSBub3QgbW9kaWZ5IG1vZGUgcG9pbnRlciBk
aXJlY3RseSBpbiBmdW5jdGlvbj8NCg0KQWxzbyB0aGUgZnVuY3Rpb24gbmFtZShpbm9kZV9zZ2lk
X3N0cmlwIGFuZCBwcmVwYXJlX21vZGUpIGhhcyAgZXhwcmVzc2VkIA0KdGhlaXIgZnVuY3Rpb24g
Y2xlYXJseS4NCg0KDQo=
