Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B0D3DE0CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 22:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhHBUkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 16:40:10 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:15938 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhHBUkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 16:40:10 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 16:40:09 EDT
IronPort-SDR: 7bv0A0t9KFrgYC0dH3Vg913W6CmDYycQGrgjliar2kwvqNTLmaoW01AgJm6sVHCgCR0PuzJnev
 m3ghczt44q3vlZgTIsROpb1fTGvUU2mEsjw7QNutpbYn9/ua4gZwtiLDucHz58fV/khnwty+V8
 EV2mvgvy8peIMMRRb0cuXTjgRo2UkUioDKkkPC5dlotri2lGLULZvq71WJrotHUj+KTuJPZcJx
 +On7INOtehKVwvk4ho5DVguwgpSx7XaDUSiTATqlyAaXt+bOejaPGClxR5Hb6AeDdKzA5qJTNu
 WZo=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 293762846
X-IPAS-Result: =?us-ascii?q?A2G9BADFVQhhh645L2haHgEBCxIMQIMsUYFXaYRIg0kBA?=
 =?us-ascii?q?YU5iGOaM4JTAxg8AgkBAQEBAQEBAQEHAkEEAQEDBIRRAjWCTCY4EwECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQQBAQYBAQEBAQEFBAICEAEBAQGBDIUvOQ2DU007AQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQKBCD4BAQEDEhEVCAEBN?=
 =?us-ascii?q?wEPCxgCAiYCAjIlBgEMCAEBHoJPglYDLwGdWAGBEgEWPgIjAUABAQuBCIoGg?=
 =?us-ascii?q?TGBAYIHAQEGBASCUYJaGEQJDYFaCQkBgQYqgnyGeYN6Q4FJRIE8DAOBBYE6M?=
 =?us-ascii?q?D6HW4Jkg0pdTmNVlVGKaF2dE4MxnjMGDwIDJoNRkgWREZYOpRMCBAIEBQIOA?=
 =?us-ascii?q?QEGgXeBfjMaCB0TgyRQGQ6OHxmDWIp8JTA4AgYLAQEDCYpQAQE?=
IronPort-PHdr: A9a23:rvf9IRefNNswwHiVXGtzh25llGM/Q4qcDmcuAtIPlb1DaOKg8o7kM
 UiZ4u9i3xfFXoTevvRDjeee86XtQncJ7pvJtnceOIdNWBkIhYRz/UQgDceJBFe9IKvsaCo3T
 9pNWUUj/HyhN0VRXsHkaA6arni79zVHHBL5OEJ8Lfj0HYiHicOx2oXQs53eaglFnnyze7R3e
 RC/sQWXq9UbkYJ5bKs910ihnw==
IronPort-HdrOrdr: A9a23:pRvjDa8jn1Sgp4/aOpNuk+Fhdb1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYVYqN03IV+rwWpVoMkmsj6KdhrNhQItKPTOWw1dASbsP0WKM+UyHJ8STzJ846U
 4kSdkHNDSSNykFsS+Z2njeLz9I+rDunsHY9ds2jU0dKD2CA5sQkDuRYTz6LqQZfngkOXN0Lu
 vk2iIRzADQBUj/I/7LS0UtbqzmnZnmhZjmaRkJC1oO7xSPtyqh7PrfHwKD1hkTfjtTyfN6mF
 K13DDR1+GGibWW2xXc32jc49B/n8bg8MJKAIiphtIOIjvhpw60bMBKWqGEvhoyvOazgWxa3O
 XkklMFBYBe+nnRdma6rV/E3BTh6i8n7zvYxVqRkRLY0ITEbQN/L/AEqZNScxPf5UZllsp7yr
 h302WQsIcSJQ/cnQzmjuK4FC1Cpw6Rmz4PgOQTh3tQXc81c7lKt7ES+0tTDdMpAD/60oY6C+
 NjZfuspMq+SWnqKkwxg1MfhOBFBh8Ib1C7qwk5y42oOgFt7TJEJxBy/r1Yop9on6hNOqWt5I
 z/Q+1Vff91P5YrhJlGdZU8qP2MexrwqCL3QRGvyGvcZdQ60lL22tXKCeYOlauXkKJh9upHpH
 2GaiIXiUcCP37yBdyHxtll6RbIBEmte13Wu7Zj26Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,289,1620709200"; 
   d="scan'208";a="293762846"
X-Utexas-Seen-Outbound: true
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 15:32:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKSirqQrV64CHzimBIq2RMtcYdMdEWknA7TdVv0+ORIRxaPa2vK24NOfo7MAkN905mt5oEybGmdC/cCAHHM6HP5MtDcb4gCqaQcpY0iCfWcTN/iQZzLX7pN2/MlTVDxmYn6yXLSf67uv8DzLZHw9KzPQudIc/v2+tweUxu0z7pdeRiCO8R5SX90ijFnAxSI89grxCaoI9Bfw7HCYqxIzB3t2+zHhAu1FEytopw6Z2tGzg6YOnLNgFPTBP/cvlSFOBgJfc6jxegqnWdR9IvmPYRJIqQiM9idrKcxrSi+F7WA4avsRxCMwdO6qJTlH3bcgoXfXKcnlr/hLrBvda7CgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArdeyMiaQbS8njnUl9V7PeZpeiFDFzPG7Cg6zFDZ7fo=;
 b=YXqm0V3ZCrGnLXL+b/uzGLEHS+7GLBL8GBGdVBfnDOv++j7hnrDgA5ufHQidXlj/W0hKg+PwVLMrI1jvjpcbRFODl3BmbbSGa/rPtmgoMJN/9Vicq39Xgzu8D27rPf5Pl6FReyPDAMFGQoTMZE+nEjzHmlaL1srNFAjZG74v6P0pTUGzkrVBx7two7NtIewjjqcXkZE2V69LFZ9Ezz5jAesjb1cnGE0k6LO0Bg01nwaTLbGLvyPb1WzwNiQLe42ENW8+suJRsKKHTntZXZJk1qO1idcagQpbcNExrD/TqAo/GjcOvY8mJycD6V1oBO0dYoIz8Cz/lXCgYnPss2kVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArdeyMiaQbS8njnUl9V7PeZpeiFDFzPG7Cg6zFDZ7fo=;
 b=gXN/ZfCS+h4dQlty8vm5afkioY9kke8Imhmfy3nWDYtsAmGDhoWynwJljZD6R0iKYwCeLJ+GSWqtlHa4Yuomt2oV3ZsFakSbr14Uy5utlMbDisd02vytqrgUgNd7DSceDk5HTYpKP0W62hlO9mVgs7TXSC/Kirq+h3ZveN2t/aA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by SJ0PR06MB7007.namprd06.prod.outlook.com (2603:10b6:a03:280::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Mon, 2 Aug
 2021 20:32:48 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::f1bb:8be5:b452:5e1f]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::f1bb:8be5:b452:5e1f%7]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 20:32:48 +0000
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
To:     "J. Bruce Fields" <bfields@fieldses.org>, NeilBrown <neilb@suse.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546548.32498.10889023150565429936.stgit@noble.brown>
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>
 <162762290067.21659.4783063641244045179@noble.neil.brown.name>
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>
 <20210802123930.GA6890@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <47101630-9d59-5818-34dd-3755e101fc18@math.utexas.edu>
Date:   Mon, 2 Aug 2021 15:32:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210802123930.GA6890@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:806:f2::7) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SN7PR04CA0002.namprd04.prod.outlook.com (2603:10b6:806:f2::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Mon, 2 Aug 2021 20:32:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aa96dea-e0af-470b-ce59-08d955f4b13f
X-MS-TrafficTypeDiagnostic: SJ0PR06MB7007:
X-Microsoft-Antispam-PRVS: <SJ0PR06MB7007056C3F044C5B5CDC83BE83EF9@SJ0PR06MB7007.namprd06.prod.outlook.com>
X-Utexas-From-ExO: true
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K52wkicWqxXGW50hUbSramOS0pHt7B0WhwEK7qWPtORxdb5wlCwrnb7krzU3xs30Uzp6l4N1wArDBt13guU3DoJ+q14OfJg2EW2XOOcqXRXy/KzWnyAC/4vaFO7S8hb0T/N4I6c/t3pG51OXsBmiVO50+/N4SfJU3LAFBI55lCFg7YWrvbFJg9qgbj0eIrKb6wahA0a7n3T+pPIJj02KlYWlhitx9o+HeY0xkFUA0c3EOmkc3Bvmf88phKagJyE8q80x0zlw+SCSnqGQsXpMFi5vMI8RiaPHykUoRYRlx8pVV1XcPRJa/5oPdB2z9L0VBxfG8SqI0gHgo8sqwiJPlciHRSxBqVEVoBRIOmQIb2Jjz6EtsnguXl3Ebq04qLMMJjn1fw7w+OSxeqAAGgLqZsRKWzwtDeCd8bTODGP+UOT1VggdcKayPF+oUxuqhTnjR5A2vsMODGE6Xd1JLUZhdfAziFNBO22Z2eEIJAR6SphtIaa3CRuCINr13wQnvHvYHKCe5XUwU6Uw6eZ976+8oi5nnTwPtmSUoTNH8FQm0SrBlyLYIREwfw4H8RfnNiF+pAOzL/tALWsStDZNyVa+7DL0yDIg/PodZei8NXV+n70lHtC9YQmkRsGqRCoCuxpeVrTMLcYpCUvaYoeboCB+kF6RQGkIbFdGvHELWS/IZ8dz0Dyze0r1hD8gbaaPrBliFkVxJccJm3huomYZ/ciRf64jmakHwSgjv8ac2KUrjfuWl7g3ViuemmxDovE2BV6SrlPL4ozttAAK0ov4uD0cBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(8936002)(4326008)(31686004)(31696002)(6486002)(7416002)(52116002)(66556008)(66476007)(86362001)(110136005)(16576012)(186003)(316002)(786003)(38350700002)(508600001)(53546011)(38100700002)(75432002)(66946007)(26005)(2616005)(956004)(4744005)(2906002)(5660300002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFA2MXA2azhqWjlGQXBPK0tnTlYzZkxUYWwwdlFuUTMyOXkrZnMyTjVVc0hP?=
 =?utf-8?B?ZzljandkTjB3R3ZnSmdOdjFWMXBjdnNvcHdpdXJYS05HMGVOMjM0S3JpdFFz?=
 =?utf-8?B?Ly91T1FkTDFyTlp6UzZXYllBZTk5VG1Nc0pwMExKLzBBQmMxR3FRSFltbmNv?=
 =?utf-8?B?RmRqWXQyYUI3bGNlRXl0bzRSRk91VjBNamZnTU5oS1R2bHQ3U2lvZTRkRUhh?=
 =?utf-8?B?TmdmSVg2ZDkwUjJlZlJ2V1dObjI4R3ZiMFlXQ2MwTEVBQzJ4VWlIc09iSzBx?=
 =?utf-8?B?V1U5RWpEQ1EyWWFMOEpLd1M3Tlc2ajhWVWc5c0tVQkNwVnRvTGZPY2pZZEQ3?=
 =?utf-8?B?RFNzTTJoRW9PVkE1MEFLbWZzY291RXFlaDNzNjhDSDE5bmRKV0tjVFpYek5H?=
 =?utf-8?B?dXBwdlRvMDlxclRXYVNjc2hKMmp2VlBsdGVZcy93ZFVrZ0ZMZTRFcVZyY2sz?=
 =?utf-8?B?dHlxTlNJbzFoUE9VRGloeng4ajZEQjFnWXFNTDJUR3VzR3NKZHhaQTlRWUsw?=
 =?utf-8?B?cTlpZHcvZWFiN0tDSllrQlZzV0lHSHREQ0pnbm1BMjRqN0RqRE8yaThmcWlL?=
 =?utf-8?B?aGdId0NMMzd1SXk4LzRiMEhMYWIrT25mTXZXbTJjQmsyT1dRay9SaFJNZllW?=
 =?utf-8?B?dnRXSndxNlZaNnVlVU5reEpNMUc0OHZoTlVhdVNiM3R2Rmc0bmtvMDFXbVBW?=
 =?utf-8?B?aFBVM1ErUnRZZGxVNy9scVIvZzY3SXZSQ0NaamVTc1o3RlN3R1lkd2pKOVFa?=
 =?utf-8?B?b0FSYUE3bjZONkZLak9XTzRZeWZ4VEErK0RxNFBYa2RydEx1Z2czRDVmUWdh?=
 =?utf-8?B?TUt3NDI1eElNcDZqT2F0WlZvMkVUYjFFV2J3Nkc0ZmVocHZLVlhYaDBFeXVX?=
 =?utf-8?B?SlhTWUpmaE9qYkRHL2xhVzF1NEtJdFZPNGR4Qkk1WFA2ZDliWGtGbnlnVHpH?=
 =?utf-8?B?c3lUbGZNVzFhU1EzUmd3V0hnVS9RVzU1ZjI2QmlHaUp6WG1ud09qQjc2OHIx?=
 =?utf-8?B?WEVxSEFRT3Uwc1FBTHNadWlwbmY5dVV4UVBCVjNZeG8wR21jWExTVUNSbk9w?=
 =?utf-8?B?M1VhVlhVanhhcGtSU3B0UHNFN2MrTnpka1FNSUREMFluQ0JCc0RodDBiYkRZ?=
 =?utf-8?B?a1ZFZHh0SUxVK2RYN0dVeEZ5RzN3NmlXcHgzUHl2d3BmSlpaOWEyQSt2enhv?=
 =?utf-8?B?aXN0eUdrQTN4d0dOQTZnZ2IvZmQwMFROV3VlQmwxblJVUTNjNVVFUGo0MmJU?=
 =?utf-8?B?S24reXBhRllOWTN5ZjRHNFpSLzNkUTVIaFUwbGxkOE5YMGRhLzFtQ3RZRTY4?=
 =?utf-8?B?bDlrMnp1K0tRUlVhZUVpQzNsNkJBU2o3M21KTi9nRUNIem82TGpzOTc1bkQy?=
 =?utf-8?B?M3JaQ1pYandrS0JQWWlkc1BDSjBHSlZyWGhTTnowUTUrZUtRVUZseGlRQTBz?=
 =?utf-8?B?R2VDL3F6K1JoSkQzL1drWVZHYmpIU1JOMFc0RThtZEZ0V3BYR0JGWXZsN1J1?=
 =?utf-8?B?MkNoZE9BbW9IVG9VaGJjNUw2SGpkYmwyNTN1ajRCdHZqRzkweXhnakVCUzZs?=
 =?utf-8?B?TDhSdHBOOFlsZk5hTEV4V0ZCL3QyQmFUSDgrVXJnQ2FvQjlnWTd1K0krby8y?=
 =?utf-8?B?RGlrWnRKUm0rc1BudkJ0dU1FOWxwSU42ekwvMEdZK2tZbmRtLzZpTUlyNGdt?=
 =?utf-8?B?UEM2QXgrbFhWWmZrT0duM2N1UTZpWUZpNktGRHU3T3NPZTlZaXc2cysrbkM4?=
 =?utf-8?Q?K0Q/yneLyvuJi77iH1/Z0doCCllwZ3JdM089DdL?=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa96dea-e0af-470b-ce59-08d955f4b13f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 20:32:48.6194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeh0F3rlItazy7W/4PcbQCYfzqj9jfmdPGYrSGngRTnMfpt86s/L+PuIsXV/Q0bLkwbibft371kH6b+QAR1otw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR06MB7007
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/2/21 7:39 AM, J. Bruce Fields wrote:
> On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
>> For btrfs, the "location" is root.objectid ++ file.objectid.  I think
>> the inode should become (file.objectid ^ swab64(root.objectid)).  This
>> will provide numbers that are unique until you get very large subvols,
>> and very many subvols.
> 
> If you snapshot a filesystem, I'd expect, at least by default, that
> inodes in the snapshot to stay the same as in the snapshotted
> filesystem.
> 
> --b.
> 

For copy on right systems like ZFS, how could it be otherwise?

