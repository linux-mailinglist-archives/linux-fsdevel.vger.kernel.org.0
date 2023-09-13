Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485AE79DD37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 02:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbjIMAkk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 20:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjIMAkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:40:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C83ACF3;
        Tue, 12 Sep 2023 17:40:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKeFYQ013606;
        Wed, 13 Sep 2023 00:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xGRCeliFQQO0sMG6td4ZP/kh66iSu9bKZgAP1OUKZIo=;
 b=hfRHZ9iNACoVr2dBqXFbjwLHVV4BC510uep1dbYF1/v1z72Ni9Ssnhn+SqUdNhAi29AG
 1zq8yyVmP/xaFOXQ8uap7uDJROgolh6tm7iDJ7Yv7dfNrIPhVr/Kjo+bzXwtZKTwrRvY
 Ct1+/70FmTnvfDlivnR4uvBhnEy1sDyTqlHugDWTVF603j142FV3bs0HiWuP3jqm2k9w
 HhU0qfAcbr+O5zMIzFHiTGbAuK53O6S/kV580oV7OjYErY19Y1ZrtTcTUc5tI4WYGfu9
 zMPP/K94tQe2Dm/VpQNbR77FHwRj0k6KvpIqh9UqJN4KRqXsMcLb8z/UAH9We/DzfwjD fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7k89aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 00:40:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CNmRwa033007;
        Wed, 13 Sep 2023 00:40:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkfsy82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 00:40:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjRgENi84ChVQ2183b8L2FQwnI0Ltd9JDhK+aaZB2Na66jPXmR98UbWl2dFWRIjW99Eo87ScZwVc2DvBx3CX2++ZJlVCeg5zUVAgt5AXCmZJE4niloWXFdM6/RBJJqFFspvNYLaD//1xyhuupBQKbPOu7en/V4c2BBag0idR/Xvm3tmetjk5SMNgBvdznh5uWFN0FEex2CzKTIL06AgXQsb2HtOW0SrzteG5jTXR/bLH/GUcw17Wqyz0jveFdZ+9x1f16SQNG3O4R52g+7bVbXeX/PZ2L6EkNNuYFtYUMvXTA8jLtCwfyJWvkZ2rt0Vrx0O6mDG2YU/d0eV4mzcCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGRCeliFQQO0sMG6td4ZP/kh66iSu9bKZgAP1OUKZIo=;
 b=HkKeuaoV17eNR78mgnkvwWY3zc19Mll7UhTSFjYVJB3eMNPk7xSj8QcFNdF/5KVhuwr/H6zv/DT0QZBbQM2z72D//r4AE1z+3zB5hmom/6yRwznOKWSzntGNFhHYMiK7vmhzUwtwf4cVsvNDFm3PzbjQwI4NU/yEsV30PgnW53JP2NKU0d8nJrUhTxfJsBGKFwgjEFWPyx3OiQUYezmtGp6BYcDTKTNu5+KdM/wmjYEl2KEVT/yfdBYpfmVfzGmuph0YNGgRWTvrETa8lBb+Gmd4IK2ZSttXsQCLCuqVvYI4Wk4eomL3EiM0qo+zxWqHWh9GFwCpnMWC3R9kTJibwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGRCeliFQQO0sMG6td4ZP/kh66iSu9bKZgAP1OUKZIo=;
 b=CjJ3o7BKkHUOI2hb/ONuETaosJEAJXiOm1QCrdvRFwswAs2lr+CjWY2Ka2M47aMCe20UejEeeNHeWCvDIIxcDk0hKP1BYd83qQGtqJY0ChxBS178dIRddEfhSE09sjDbh5OuVMKWML9UNNrw00n5/yJJbq1j1Y32h0EIZs/qfhs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7380.namprd10.prod.outlook.com (2603:10b6:930:97::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 00:40:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 00:40:04 +0000
Message-ID: <4914eb22-6b51-a816-1d5b-a2ceb8bcbf06@oracle.com>
Date:   Wed, 13 Sep 2023 08:39:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230911182804.GA20408@twin.jikos.cz>
 <b25f8b8b-8408-e563-e813-18ec58d3b5ca@oracle.com>
 <6da9b6b1-5028-c0e2-f11e-377fabf1432d@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6da9b6b1-5028-c0e2-f11e-377fabf1432d@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::25)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2187b9-593d-418b-d772-08dbb3f1f83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGJQOdNAA/ulsCG2MVrU5xTke6Eoaugs8WowANXae96udt4ibg23CWR33L9WKvej3QyGEGWYNhCS9bhXAUfUfmKSAd5fZWhRgKpK0w5r6lUCavFAHTeVM5lqDyB5uvbnUbeXQzxxWG38eotnGw/WyTIXRGl7qzCvRkrx0TZYHSygO+H5gY8uaalQvvhJtUQ2fxSTE8JWtVm1v8QPFx8z2HTo5QuMHYz3s4hgyEKluc7fJkWMgqgYutqnCFqyz/mE7FcEbOl1Ppzoi1Ds48PP49bzowcwRfbwBhl9G3jPllYznHioB/+94w9tCngVJ0/beUXawYuWF9ahY6Yh7vrgiBFmprUqwjXDsB4Z+hh8C3GYo7meT4g0teohyIIwJtEGl49Qf4+QhE7upAWL/mzQV3CwgEnZrH0OGF3aLFx0kEeHfO/zFydKlHMHMxL+aOFCvo9t/5Llhr9U3V33NBkpxA3CF77wpZbUgVoG9PbejWXWywZimYYfSB23/rd0vbnJMveK8ynsGHjr+6m5XqITDnlWAgAxF87LJ0I1nieKp/pyysSW62Pi7YAYYxTT1VdWor4MCM7NKOB4g6tf/z8+RIEUArhPXQES8qZGgrwKAcSKOxVdXMrUJCFX/AFpoTIuJLE5zGxOsOBzhvm7VK6RdpSXIXm1luijWvaPTvkyBpTrjfwaWgPMP/FV9QCKD7dN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(186009)(451199024)(1800799009)(8936002)(6666004)(53546011)(6506007)(6486002)(6512007)(478600001)(66476007)(966005)(2906002)(66556008)(4326008)(316002)(5660300002)(7416002)(8676002)(41300700001)(66946007)(44832011)(2616005)(86362001)(26005)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXQ1UXdEWUN1UDFOU0NJUFhxaEV3VGptelUzNElxNVRvWkpFblJHWTJkbTJx?=
 =?utf-8?B?bGR1VzB3N0ZWYnY5OStxallXYnVIUFFOSUZHRHFsU3MwMTFnN3JTZmZKbHFS?=
 =?utf-8?B?VGQyMnpYakY4M2dSeTNDNmE4bEF5K0YxRjRIc0R4dUdqUWRuMDVXZzNiNjdt?=
 =?utf-8?B?bjAyUDJydUhFYlJnZ3JYVFZEUjFEUlpPdHViKytHUXBlVmVucE11dUU3L0RJ?=
 =?utf-8?B?TlpGMmduQWVmS28rQkJYb1o2MDlCajFLYTMyRVRGSnVzMENub1MybS83SFoy?=
 =?utf-8?B?SG5acTNMVlMrSHpGN3BQR0xSRlVBR2dzR01oUDdFN1BadWhIRFBUMlBjR01m?=
 =?utf-8?B?SG53cXBtQUE3UlNHK3BVNU4xNlNMazhSTXdoK2wyMUw0b0FzRThGem0zd2xN?=
 =?utf-8?B?Ykw0UVNiTFVkWVBOTXpITUE2WGcweEozeWMyNkFRRjc2R3k1MkxsK0VRS00v?=
 =?utf-8?B?ekN1clNxc0NaVy9MK3MzN1g0dnEzRUNqcXk0WFphRFRLQ0ZPeEsrR2U1WGRy?=
 =?utf-8?B?Wlk0TUIxbjR2MDdpVGsrK2tGNW51cGxJTWxRUm96QmROYnRtWUF6aUJNbEhq?=
 =?utf-8?B?eWEzNmQwTU41U1ZOcDFXbEMzRnJRZGNuNkswR3MrdUlTUmJFd3pwVVBFbTlk?=
 =?utf-8?B?KzBqaUNtQUpFbVhtUUN5NHJYYnVYWUdETUFUUXJtN2JzcW9WQ2RvckpuTGlZ?=
 =?utf-8?B?NjF6V0xHekNzR0xQTjBnNGIwZTZUR2tQbVloV0dpd2JVTU9NS0NwcUhIcVlX?=
 =?utf-8?B?T2JRYTc0UGs4NWFhcUdPbitZMjc4NFJIcWhPc2FQS01CSHhwS2FSTUp6TThY?=
 =?utf-8?B?eVNReityQjNSUy9aNVZLQWR3cVhDMkplcDhwNTd3OFVneExZQllqTXVDbGg3?=
 =?utf-8?B?VlBlZGprcHdRZXR0dlVXUkpLZ2VSZHRaOTNRWkgrdFl2RXBtWCsyeHZydlQ5?=
 =?utf-8?B?MjAwYklZMkJOZDVEZzlSSDlrcVR6SG8vblprbGJaQi9pY3ZpWm5xY05yVWk0?=
 =?utf-8?B?a0pIMlZacVdtdlUvNnM3WWJ0ZzZxdG1tZjFSZXN3cG90WUNpc1hsUkRiM0JY?=
 =?utf-8?B?UnBFa21PM1dmSW05dU84czZ5UkU2ZUZUa1FGaXl0R05IZ24zdXJ0cGMxSXhv?=
 =?utf-8?B?TkFUaWNPSCtVbE9wbThnRjA1ODV6MkxyS0FwdFhsUGt3YkVQUHMxL05UQ1RH?=
 =?utf-8?B?clF5V25kbGRrSnliNm5sSWdaeFhPelNKeG1JR08yRVk5K2Y0QUNVWWM2cSt5?=
 =?utf-8?B?N01nbGcwMnlWY0lORmU4aytCQnpURnZ2ZjIvNzdTUEtUSm5vNTdpRXRrSGFF?=
 =?utf-8?B?TWNWNUUzTEVjMWJvQXFjMnI1M3U2cUpkZmxUWEFSaXNOSEIrV3dWbnE0UlVP?=
 =?utf-8?B?MkpiNUtxbENDNFppZmI3Q0VNb0VSczJ2Z3RtcitCblNSNFY2ek9UVUJhT01n?=
 =?utf-8?B?NjJ1RjByZEozMWwvWkRUTDhoVWVPWkNQUGpqM05DcFpGdDlBcVhxK2xpd2FI?=
 =?utf-8?B?OTkzQVJlRm9kYUpHOWhqUWEyMHZycDhTVDQxUnpFY3drd0N1WWpPbjRzbldQ?=
 =?utf-8?B?NTYvYmlmNFZXMjJLeVZUd3hKbWJwWGNkZkdLc0V5bkV6TlNZZEI1R00vN3A2?=
 =?utf-8?B?Y3d3R2tEa09ET3Jpa2lDL2c3dUlka0lhdHdjaEpWSDFEZnlTbEIwVW9OWFF5?=
 =?utf-8?B?UTZudWc3THZ2Sm1zSjB2cGRsN2RkLzhBQUdtdGZOQWZHWnlrWW5jN1R0bHdZ?=
 =?utf-8?B?YXErWkY0S1pkQjJrQ09CSUs0QmVlZnF0Zm5ISGUwVE9VbDlCK1BsMGpkYjRy?=
 =?utf-8?B?T3ZkY0ZYWXJYRmsvdm1abCtHckRMUnpWY1pPRjRZSHFUNFBOMlFBbEF6aFc5?=
 =?utf-8?B?K1hXcmNJN1lub1NGQ1lRVVF0RlR3am53cFdqMy96U2F2K3VaNkVONWhnRHZX?=
 =?utf-8?B?ampOcjBvQUgyZldVN1dyRTh6WUM2M0N6YzRHTWVNNXVUa0trcnVCK2hsOEQz?=
 =?utf-8?B?dnJrQmpCSEtNZUVnTE9MSjdTY0ZtckFrNTRLNVM2MVJiblZIMkFmelRGQ3RZ?=
 =?utf-8?B?YzBuYXY5c1ZsSTE0STNmdFBNM3VieFhLYkdKY1NLYlhaaDZSMCtYYm54NUEr?=
 =?utf-8?Q?zUUfmy53mDpxXzVj5+LNhLurO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YWhoWmdBTWQ5V296bENRNHFzR2d0RDdVWGxuU1l6eDZEKzNWV2UxeUh6d0NN?=
 =?utf-8?B?bGVRSzc4Vm1EdTN6QVlXbmJ0d0dJS2k2Uk9sREdCSXFEd3FNZGJvSG9yN1px?=
 =?utf-8?B?ZmYva1FmempQYTg4aXZSU250Q2pmNWV3SFFDcW1PaDc5Wk1tQmFFcWZBWVdv?=
 =?utf-8?B?Skg2cEJub01adVF5V2phMVpRZkVzNHo2OFM5Q1p4ZUV3Z2Q1TE9SL0NrZnRH?=
 =?utf-8?B?M0JVLzJUMnQzWkJJOEVCMlcya0oySU1Cb1F0dVkzUUVaZEsvMjFMZWpQZVg5?=
 =?utf-8?B?Q29wOG9pWFBtTVdyV3FIcWtoNkRIT2RMS3pvSDV4a05FNjM0VTloT2Q5NGZj?=
 =?utf-8?B?WTRENnFiNFhQSHJQRjlhd09jRkhXeU4rUDhJQlhLSE1NVTZ1ckI0dzVPWUNR?=
 =?utf-8?B?amRvTFl0WHc4Q2hwdE43QW5FMy93SDZ2NnliSDIxQTNpelVuOW9kOTZqTm5z?=
 =?utf-8?B?UjdtZEZYL0tRRTVCZGRhdVFPNjZJbHBYWTZkZnZITDVJN09CdUwzTHFQUUhw?=
 =?utf-8?B?NzlZdllsQ2piQ2FhVDFhZWlXTytKdnNjdFhYUU8vUVB0UTMxQU51WWYyVlpi?=
 =?utf-8?B?dmt5VmRGbVBNSTBEbmFObVBlWFFMV1l3L256TUE0bTRVZmlvUmJkT0tsUmdn?=
 =?utf-8?B?NkZJWW43Q0lUL3pWbmdsUlp0ZGdQbStqelFicGdQUmRma0g4T0I3LzNwcHZT?=
 =?utf-8?B?RG1IOFRVWUhwajBiVVNUbVFrcnRiaVRIQWR2SXlRVXVUWVpLWTQxa0txWloz?=
 =?utf-8?B?T0JXeTkrUTZJaVhhYzVwUkhQTDF4ckRncmJaQi9XM1pFcXJJSjZwazFoY0Ir?=
 =?utf-8?B?ejZ4Wk52OWFRTHpuT3I2Vnd0Mk9yTHJKYWFHbGlKOVM3RkU1OC9iV3VNbUts?=
 =?utf-8?B?YUtDckJJRW54dzBSVTdVaHVVajEvenpWTUdCa0VpM2VhemNoZktXTW9wcGRr?=
 =?utf-8?B?NW8xcjJEbnBSbGxBSE5aVHU1TXVZWUZ3RzU2TXhPaCs0S3ZZRnpyQjJ1a2RF?=
 =?utf-8?B?bVN0bFZJN2hxQ1VnS2F4aUUyNVpscmNSVHk1SE5KMHd2VW9DejFmRDFRbEVS?=
 =?utf-8?B?eXEzaTU2U2FWTHFRYUJRM0hzYVJ1L2RFdEJIWWx3THN2S2ZlbXlyVmxPL2F3?=
 =?utf-8?B?cktSbnEzK3RuSGpnRHBzNE1uSklNbll2bXlPWUF0TGtTNUxnUk4rd2ZvWml1?=
 =?utf-8?B?SDJtR3pmWWI1OHptbkJON1lVRkJUL0JRVU5UMUxHdC9zOTJnZm04ZzVPV2ZS?=
 =?utf-8?B?NDRmWHB2QmpoUlpIM3Z4cjk5TStXMDl6TWJlcEw4dGd0Ym5SSDh4QlR3NmRR?=
 =?utf-8?B?WVkxNnZkeFhIQ2V3ZjNXVCtEM2RVV2g1d3BiUzNzU2ZPOUhHcnRqRGRuMG9s?=
 =?utf-8?B?bWUxMVpNWWJpZ1VFSVpmejluTXFzaU8xV3FJTTREOURFQit2T3JhNkFIbWxL?=
 =?utf-8?B?bXlyQkFFVlI1MnRQamJJT21GSzVKR3ZXSlBTNVRmcmJ3QmRiSnlKZmU4TENR?=
 =?utf-8?Q?y6IV5U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2187b9-593d-418b-d772-08dbb3f1f83c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 00:40:03.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HiZVvaweo8UmT7zSLJoXrqDUG8zgqBjgj2g4u3ZpeUV4EGspnSRX0Ci8c7zv2bryIYNdttfvl/3VOtYQ3tXXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7380
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_23,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130002
X-Proofpoint-GUID: 6DRfR6W6o44dCXz-ytyURbPgB_dGAkrr
X-Proofpoint-ORIG-GUID: 6DRfR6W6o44dCXz-ytyURbPgB_dGAkrr
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 13/09/2023 05:26, Guilherme G. Piccoli wrote:
> On 12/09/2023 06:20, Anand Jain wrote:
>> [...]
>>> I've added Anand's patch
>>> https://lore.kernel.org/linux-btrfs/de8d71b1b08f2c6ce75e3c45ee801659ecd4dc43.1694164368.git.anand.jain@oracle.com/
>>> to misc-next that implements subset of your patch, namely extending
>>> btrfs_scan_one_device() with the 'mounting' parameter. I haven't looked
>>> if the semantics is the same so I let you take a look.
>>>
>>> As there were more comments to V3, please fix that and resend. Thanks.
>> [...]
>>     Please also add the newly sent patch to the latest misc-next branch:
>>       [PATCH] btrfs: scan forget for no instance of dev
>>
>>     The test case btrfs/254 fails without it.
>>
> 
> Sure Anand, thanks for the heads-up!
> 
> Now, sorry for the silly question, but where is misc-next?! I'm looking
> here: https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/
> 
> I based my work in the branch "for-next", but I can't find misc-next.
> Also, I couldn't find "btrfs: pseudo device-scan for single-device
> filesystems" in the tree...probably some silly confusion from my side,
> any advice is appreciated!


David maintains the upcoming mainline merges in the branch "misc-next" here:

    https://github.com/kdave/btrfs-devel.git

Thanks.
