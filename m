Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D21216A75
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 12:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGGKgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 06:36:54 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:48768
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgGGKgy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:36:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdDmBjO9El0pbbzqjBGnYfHoxZW5gS+Ddwjf5Ce8oBfyZbrwU/N3mbmCa8wSNImoqoAFSN/bfygk6MFVHOuOQ1l/SIbswU/zd+GMVft3TIvVqj+tXLRUeHAtJwJuaQdRTuqE2OoAWlRkH7oydohZMVz8YPANpYmEJCKIXp740/eo85c3O8N8n4GbkpmeyjHRsO2rwyyUqHTBmpqhZ6uxNiO/MNP+S/bEQI576MmD1OltqHMbPg9EpXoesPM7RwCqQbkCTg+GmZmyDehShm4vm4t7xCm+iPbBzZXX+8CHFWE+ENf/7ZzXsPFwzDgdfdXl8m7KhQFbXhIDoeeOnOPTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhPYv/YUtRWTZ9nxMkm5KNoRROhH9jL0P6S2qL64FhE=;
 b=fhRdtV9z951mAfH4vowh3X1HYlAYK+7Hg+A1+tUHL16Mfbt1azAq91G4PsRwYtVpqwkHBTwT/vQVCk9kqENrshBZDHyy4/eDQWf/VlDZYBCL22bkIIlhQ3c5OHkg6o0Mvyw06Sek8Lj8RvCJkiWwLNs8tmducoBYNCJ/BElNuLF1mFVhG7ku/3wy/Y02s2usa2/Dsl1Dc8c8ocX58ci3yikzLOdF5z5BSj+jnA2qv0HVdYXJ6siRg3JR2vYUNfy3BXSUNpTDJXUIREqlCcK9EwvgYunGmKTXPbCfAl5hDorhsYk0Y541AdgKUtLAWuXw7YOn3VrrBqCsiV1jxgMx4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhPYv/YUtRWTZ9nxMkm5KNoRROhH9jL0P6S2qL64FhE=;
 b=k+a11Y9NVdms6YzZ8/Hi6yc9bP27kf6I4n/vvE1kxTjdOotWaqsXj3C2nGP6+Bv0R+SRFmDWq4lIJe8Eu6DU9+ikfjJm4YU8L/tbrWU0keLRmliObu8SX2ZtoWc/HK1Zrnk+ydyj6SYV0xcg31JmvYA9Zv/IpUTZSmZ32f/0m08=
Authentication-Results: canb.auug.org.au; dkim=none (message not signed)
 header.d=none;canb.auug.org.au; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0151.namprd12.prod.outlook.com
 (2603:10b6:910:1e::14) by CY4PR1201MB0168.namprd12.prod.outlook.com
 (2603:10b6:910:1d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Tue, 7 Jul
 2020 10:36:50 +0000
Received: from CY4PR1201MB0151.namprd12.prod.outlook.com
 ([fe80::6d1b:3185:6bd7:31dc]) by CY4PR1201MB0151.namprd12.prod.outlook.com
 ([fe80::6d1b:3185:6bd7:31dc%7]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 10:36:50 +0000
Subject: Re: mmotm 2020-07-06-18-53 uploaded
 (sound/soc/amd/renoir/rn-pci-acp3x.c:)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        sfr@canb.auug.org.au
References: <20200707015344.U9ep-OO5Z%akpm@linux-foundation.org>
 <b54188c7-47b4-b7e4-2f74-6394320df5df@infradead.org>
 <e19cd74c-df3d-9589-1fc1-55980a8d289b@amd.com>
 <2af9510e-b3fd-97d8-c2d4-1c42943180ee@infradead.org>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <ebe0bcc3-48be-3037-1670-4d83f0f6e498@amd.com>
Date:   Tue, 7 Jul 2020 16:20:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <2af9510e-b3fd-97d8-c2d4-1c42943180ee@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::19) To CY4PR1201MB0151.namprd12.prod.outlook.com
 (2603:10b6:910:1e::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.129.8.176] (165.204.159.251) by BM1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Tue, 7 Jul 2020 10:36:46 +0000
X-Originating-IP: [165.204.159.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a6d91f5-59e2-416c-ca10-08d82261a807
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0168:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0168440D456878AF4ED4DA2F97660@CY4PR1201MB0168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hEf8wMquT3NXa3LbqoY2UJ1lmRuhQKpO1uyrvjaQk3/QwAdHURyGyVNzWovcPENjCd6u0tT2jr3Q2cp4uTbFXuhRaYrnvTn5dtiQdRRCFfYBk3uiT3aVn4V9x7E1+SuWVPkAfb/P1XSXH5nht86Hx1fLd+rYigbUvnCRorc/o0fS02GQRWJoJY+Z3d7t6JINH3TJddWsKunyRa1ti4cvp0SJ86dx/4odTBkT4jbFs00dgjFOOgpmvtoQK/H5JI8/abcTSOoHcfHuIAxoBdYYOdkKOMrh5nXUIjQBgm50JgLlP1CIS78p2DHGihxndWzpFSmDffLn5rFslPiT1laPn+n/VBOEnB62B4uLituXVF9pyfZ4R8pgdm0t9AVoUGnv5/m6Pf1dCpyNm04BCHWE/wllmSHzg+Y+cUykcp/mObdssXV182ovb6Zk2o6590zDwowSO881NxHY1w0TgcLGzk7QBQ2Fs7A8FcI1aazGNug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0151.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(26005)(7416002)(8936002)(86362001)(66556008)(52116002)(8676002)(66946007)(66476007)(2906002)(6486002)(16526019)(53546011)(31696002)(45080400002)(5660300002)(31686004)(966005)(16576012)(316002)(478600001)(186003)(110136005)(36756003)(2616005)(956004)(921003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rW2kyMM2NAI5MHFDlgzeManY1ZP21Wa8Ifrh125kO+DdG49ZTYan5bh0AibrGE/eYD+mGObFKe5ZrCgEQ9TUp5cO2PjzMWpfXPeAYwOBMnFkifJW/7AYLk6b9XLaf442NDf6xjLf3dFIebpg3wNO/HWGNWvgF8sGyigfC9KG4Y3hJwSDvBJ92/PGkP79UmIiQHTpH+9LpvgoqbSycL/diaMw93xTtdfXkpWrAf6cmSrfiH0L5fhHekTFE2wn0sUm41PhB2Dpv0+9cFIJt4NCRfHRKnpte2Mr0gELoihm0lPOeIhg9VfITFLsj3L99wGZRGahoZta4WS2tdb3MwcLVGcUSelAlVkjImZtr2DwkCCLB4VquHzm4wMjK75NQqjXAA62b2wYhgU4qi3dod6H2yt5kvQx1MpYZ1icc8nfBOuIimBrGr+Z6r4vj3m4W87DHPMcVfdqeCHEs96BQazlW+RPD02ZLq5+zVd3RBAYSgjYE8nLJOme1JF4210ihkUO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6d91f5-59e2-416c-ca10-08d82261a807
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0151.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 10:36:50.1708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cES4rOyR2otnp8wObgZkX7QWWs29VKh5ubKK1NmZrTVqDSHoD4B8ooYFBD/vwu5Ex7N7h+a7yreNy95dvMSPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0168
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 07/07/20 11:38 am, Randy Dunlap wrote:
> On 7/6/20 11:15 PM, Mukunda,Vijendar wrote:
>>
>>
>> On 07/07/20 11:14 am, Randy Dunlap wrote:
>>> On 7/6/20 6:53 PM, Andrew Morton wrote:
>>>> The mm-of-the-moment snapshot 2020-07-06-18-53 has been uploaded to
>>>>
>>>>      https://nam11.safelinks.protection.outlook.com/?url=http:%2F%2Fwww.ozlabs.org%2F~akpm%2Fmmotm%2F&amp;data=02%7C01%7Cvijendar.mukunda%40amd.com%7C1707f719e862439351d808d8223c28f6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637296989101868555&amp;sdata=zwcKEzTT4zHSr38qU6hHYI5qLCdid1Af0YJZsp9n8W0%3D&amp;reserved=0
>>>>
>>>> mmotm-readme.txt says
>>>>
>>>> README for mm-of-the-moment:
>>>>
>>>> https://nam11.safelinks.protection.outlook.com/?url=http:%2F%2Fwww.ozlabs.org%2F~akpm%2Fmmotm%2F&amp;data=02%7C01%7Cvijendar.mukunda%40amd.com%7C1707f719e862439351d808d8223c28f6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637296989101868555&amp;sdata=zwcKEzTT4zHSr38qU6hHYI5qLCdid1Af0YJZsp9n8W0%3D&amp;reserved=0
>>>>
>>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>>> more than once a week.
>>>>
>>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>>> https://nam11.safelinks.protection.outlook.com/?url=http:%2F%2Fozlabs.org%2F~akpm%2Fmmotm%2Fseries&amp;data=02%7C01%7Cvijendar.mukunda%40amd.com%7C1707f719e862439351d808d8223c28f6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637296989101868555&amp;sdata=mzNHUR0CpjfaXX6Syq4sjkR3i3JU3jGRm7CcjKxFmMc%3D&amp;reserved=0
>>>>
>>>
>>> on i386:
>>>
>>> when CONFIG_ACPI is not set/enabled:
>>>
>>> ../sound/soc/amd/renoir/rn-pci-acp3x.c: In function ‘snd_rn_acp_probe’:
>>> ../sound/soc/amd/renoir/rn-pci-acp3x.c:222:9: error: implicit declaration of function ‘acpi_evaluate_integer’; did you mean ‘acpi_evaluate_object’? [-Werror=implicit-function-declaration]
>>>      ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
>> Will add ACPI as dependency in Kconfig for Renoir ACP driver.
>> Do i need to upload new version of the patch? or should i submit the incremental patch as a fix >>           ^~~~~~~~~~~~~~~~~~~~~
>>>            acpi_evaluate_object
> 
> Hi,
> Not my call, but I would go with an incremental patch.
> 
> 
> thanks.

Submitted fix as an incremental patch for upstream review.
> 
