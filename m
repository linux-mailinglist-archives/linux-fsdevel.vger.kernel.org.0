Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00B421661D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 08:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgGGGBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 02:01:21 -0400
Received: from mail-eopbgr700074.outbound.protection.outlook.com ([40.107.70.74]:50529
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727827AbgGGGBU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6h2ITVMkwsNsuaqDHwLTHVUOKbmMnTbbxe6f8ffrICl4GWsezr0OLzSM8veTwXSeZtNG9QbEPV3X6qjxq04SPQqJ0L6gD062QZZuSZJXxKS7Uimf4of71gCkVdkwVWwzndUvM/h6uY5BpoZGzamWwiY1k3L9mwNjldQoK412hdrAaXJed8T5Se7xQgmT8pdltJMEN/t34Ro+HoySFLMdubfP0qoNUdgZG5fnrYP5i3i3oSLgVQqemvSxNQYNchZN2JnqeTNokriDpj8iiXWLAJSrALPCI0M2pjuBOcEnBveSXor4K/uHyz+Zg6fOLWA5KKhnqjw4pQNSLqNNgqIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz2GdaYZmkjEy8mycziVJ7iOqvcS4nt7Rf8r+i4Kzcs=;
 b=g42NpqtGuAh72NggLJIwcwoZsNG2ZIQ8XE2yTlXAWuOmMWEf/bnjGDEz9tmrLfojBL3gFeo0xp/T7doXbql4wRBHuVDPWHEIeqMTEL3K2Yrn/QgRc6GeVjCMva8AqqECa48GDOIxI3B23c8JJyUFkqOXsJE47YXhB1aBlsK2sIZx2GcVCRCYWd4ZxUa05QEU77s1k+OSuxz6PCMatVKvh4PGQcZLDrCqAJdZJXe4y/7YwtPxMGu3BwfylA4xNQeQYbhnv67ahywTOdxZIlpE9oxOzpDnnhl8acydqusaHspv4CbpfKtQ7kaFm4Azy51MVxYuXIVFkeKKgKCrdbUhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz2GdaYZmkjEy8mycziVJ7iOqvcS4nt7Rf8r+i4Kzcs=;
 b=PEUD76WUYUDS6k9ISM9OLKFgF0KSHf3U2rTI/epKKbN/7VCPraX9+87CGUXUn22eby4FA9a1G2RcbigQCAOT0rkdsM3ok0NiOJh4LCG9vXsWiiSxDD2W8iCNf+ngZnB88cB0g3qLEfCxhqEu7DreF1fAifGKPwnB9fsUClvvPyE=
Authentication-Results: canb.auug.org.au; dkim=none (message not signed)
 header.d=none;canb.auug.org.au; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0155.namprd12.prod.outlook.com (2603:10b6:4:55::20)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Tue, 7 Jul
 2020 06:01:16 +0000
Received: from DM5PR1201MB0155.namprd12.prod.outlook.com
 ([fe80::1477:12b0:571:5000]) by DM5PR1201MB0155.namprd12.prod.outlook.com
 ([fe80::1477:12b0:571:5000%10]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 06:01:16 +0000
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
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <e19cd74c-df3d-9589-1fc1-55980a8d289b@amd.com>
Date:   Tue, 7 Jul 2020 11:45:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <b54188c7-47b4-b7e4-2f74-6394320df5df@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::11) To DM5PR1201MB0155.namprd12.prod.outlook.com
 (2603:10b6:4:55::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.129.8.176] (165.204.159.251) by BM1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Tue, 7 Jul 2020 06:01:13 +0000
X-Originating-IP: [165.204.159.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93b3d03b-dbe3-4225-8817-08d8223b2959
X-MS-TrafficTypeDiagnostic: DM6PR12MB4233:
X-Microsoft-Antispam-PRVS: <DM6PR12MB423347FBBDBBD5012395505397660@DM6PR12MB4233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkxRyGRdPM+14kMb+9K6s5CLdN3C2s83xaGGrqSQqyV9R4qAw6Jp1zr4KJ4SYJRvWm6C6xhVUoN8FjobaXviDBvougYg1Oy3TLHmTTwuLxImhjGOObq0KcdVwxcHjnfHrHxjUF6lC5t7Q47joKRCkd+CIxMJc1gwSW8fvdd4Xdx8Zfv7yKNUgLIfb7iS4hEewzyj7Xvlsr4Nup0y+kWbpnK0oOfMVOgjbQduSGo7H3a5G91N0KxziXVX9ZhLDL2/fJG7ZKwfoDM1zboCfSTmMFRscfmvhRppIOuSHoZQYnNtqDb2f98FjlQ0xrWPtz63mzLjjl09rTK+uegGF77ti7d5stdaoc2XHSlF6DWOXfQywKjlPxIGMK4pl1z+7/qml2tGvglqNrwVtLz4NUztpzMeNch4hYEC6LNnzcWf4ktXbnAfKZjx+P9BRBGzX6tS9gk4HUu3jD/lV9AiGs0j4M9hTi94f7YObArZYX8+khk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0155.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(66476007)(66556008)(66946007)(956004)(16526019)(26005)(186003)(2616005)(2906002)(52116002)(53546011)(31686004)(86362001)(7416002)(478600001)(8676002)(36756003)(110136005)(6486002)(966005)(316002)(45080400002)(31696002)(5660300002)(16576012)(8936002)(921003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eaBC5QbNtE2FTrLzymnpNwfYNJ0hggwnFsDi2ayna0as6MhmhDPR3t00FP/1mcMoYMriXRCoKpcy6Iqwmgbcz+k5bn7pPqR0hB0i1Nyg6B9NDyfkJaKd9ZqeV0qq98KUf2miGd06m1MZvf3yun0ChhzM2bMbw4yomVnZN0xc+9gZ4XKnPPhH1bR++XOO2D35H+nzlXCKPjU6CJw8G8SaAitnu8f8yJPLA34k9Xvm+dn04jKfzsumh8GhxuMplWdOxxN4Fca0WOsRy06JrOaMwYGq+rIVQAblZBGnjgORGTL7pKWX6OKbzipClt8rMb49Vsuh133v8rA8UVcsBYC3kkoG1RgN9sFcsLitkYGgljuVCYFCwZiI6DBMsD0uMirF2RvwpR/pKYSo2CL4WIbZEntNXVSjeJkeWRs8WjY9p+LDg3uzVjO2OGhA5gM4p8zOxq6+d4Ht43r7AATKgqNFVij+Gho+kNjptVjD4uLAvUOcdzc/TSXiYx87dbunHnIB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b3d03b-dbe3-4225-8817-08d8223b2959
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0155.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 06:01:16.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJghM31ksZ82DlTXWKIj0azZ4VntXm3c5L58wyKRRJqqx2y4T+VSk6EAQMv2gPEJoPBpPEUb6ViwmU0a0XfQ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 07/07/20 11:14 am, Randy Dunlap wrote:
> On 7/6/20 6:53 PM, Andrew Morton wrote:
>> The mm-of-the-moment snapshot 2020-07-06-18-53 has been uploaded to
>>
>>     https://nam11.safelinks.protection.outlook.com/?url=http:%2F%2Fwww.ozlabs.org%2F~akpm%2Fmmotm%2F&amp;data=02%7C01%7CVijendar.Mukunda%40amd.com%7C34f06090b5394f9ccb9d08d82238c5cf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637296974530250787&amp;sdata=K8z5g9P5S7Ct%2BojnITdP0xuz159sYOiDWOyUy3abDpo%3D&amp;reserved=0
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> https://nam11.safelinks.protection.outlook.com/?url=http:%2F%2Fwww.ozlabs.org%2F~akpm%2Fmmotm%2F&amp;data=02%7C01%7CVijendar.Mukunda%40amd.com%7C34f06090b5394f9ccb9d08d82238c5cf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637296974530250787&amp;sdata=K8z5g9P5S7Ct%2BojnITdP0xuz159sYOiDWOyUy3abDpo%3D&amp;reserved=0
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> https://nam11.safelinks.protection.outlook.com/?url=http:%2F%2Fozlabs.org%2F~akpm%2Fmmotm%2Fseries&amp;data=02%7C01%7CVijendar.Mukunda%40amd.com%7C34f06090b5394f9ccb9d08d82238c5cf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637296974530250787&amp;sdata=6CpbYkoZTJ%2FxqhyFKdZMjH%2BdG5kjOgogt8KqqNK%2BzSI%3D&amp;reserved=0
>>
> 
> on i386:
> 
> when CONFIG_ACPI is not set/enabled:
> 
> ../sound/soc/amd/renoir/rn-pci-acp3x.c: In function ‘snd_rn_acp_probe’:
> ../sound/soc/amd/renoir/rn-pci-acp3x.c:222:9: error: implicit declaration of function ‘acpi_evaluate_integer’; did you mean ‘acpi_evaluate_object’? [-Werror=implicit-function-declaration]
>     ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
Will add ACPI as dependency in Kconfig for Renoir ACP driver.
Do i need to upload new version of the patch? or should i submit the 
incremental patch as a fix ?
>           ^~~~~~~~~~~~~~~~~~~~~
>           acpi_evaluate_object
> 
>
> 
