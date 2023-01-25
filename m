Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF8F67AB1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 08:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjAYHni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 02:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYHnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:43:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DCA3D0BA;
        Tue, 24 Jan 2023 23:43:33 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P7egrJ002845;
        Wed, 25 Jan 2023 07:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MlMHoMW7Wgp8+JHmPfdKUfXlIS3m4deceHGYSXghQwI=;
 b=a7Gyl/GYOCFALEw01PZgp8E7Z/7X47bnQmX32eLPMJsHE8fNGsCpCKF9SKBUGONufR3N
 jfTJzKgfCsVhI98ctLUqXqhOk9bDlpc7CFijE9+MsCbvRnu4QL9slMOwQRRmrvRbcwuj
 AqFSDGAdksVKmVBXxoKmlIviKlbndq8bwGsms68X5R5aUE7fFYgLJJ6TOxN/rHaNhe0O
 TBId4u45XjJtyUWcB0V+U+dyklDpPmBUOIZZ7y1OtzLPUcLzPPC8NICvu+6KeVv/i/6m
 slL/r2XAYFlfZc66kO5SVOoPx8RZChhPQm6oOgPlFJ2+h+IAljQkG+lMPtLRW+pTm5si RQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88kty5ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 07:43:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30P6pnuV025236;
        Wed, 25 Jan 2023 07:43:15 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g5ms76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 07:43:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkh0ije/9dRHCmASIdGFjyYqrSrBHZmTKpEZxCypKQpae0Lbm01nEkwm326scTl7hEj1wgslZjcqbMKvmov5p3XsaVEdOGTPYsWQWq57/4HWsqAuluKOFfNKMdm8BSltKVxtUWvPOjp4pBqJ1JfVBZFPo5LPtFq3qmphaC6CcPEFuzw+Iryed1e9yXDKzQd9nlK2p+3KpMUB62jKlrdjEkhSO3Pt9tC6sMRcjvyr05s5G8Q/jkm4XdzanFDFtz0PE47LE/VPm7ILaWPySGCVpuFMCiCmZOhal7jzL/cOQLf1eOiAXdBy9aVmTZoRceqBC4vg4BjLKGW06JDxhrLrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlMHoMW7Wgp8+JHmPfdKUfXlIS3m4deceHGYSXghQwI=;
 b=DPMUcXSKrhh7UeOogTM1TfKehGnAQbr9LDCX0nWJMpfHB7n+1Pyrmk5B7rlRhOE/LbxPe7ERZFarqvZbvu30ul/aeeuhf8vVr1pUpwlWnLQj2qrr90qiIE9ZoUIR1kl9Tw3hXFhUOgYP6IWEcmh6wpllmI67lbEmt0xbnfYuXLOsM0PhgbzJ1jOqhKDlfZoOheG229EpxmXDWql5S3KpXZbgN0lG6DAmHxiZeYomqf8zJIdF0+gmfvNivaFYy8CrJMRpOCUMNg4mykCOEuT5theT2Vt7u13PZHdRnFhncBL+/xQg9SnUFPPeNwOygZ5HeKfB0A6ywo0ZaBOnB7iviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlMHoMW7Wgp8+JHmPfdKUfXlIS3m4deceHGYSXghQwI=;
 b=VI9mFczJjsMYDXMq9nb/T+biaemaluelKYIUR4Lieh/13ZcsiBSo76E3qBR9oOp+Epk7KELnLiuFTnv2v7buLG+2fsIpee0RrCg1lvFIkCGW0pZJ3rqFZidq974M3sQUV5DvexFdFoEcGEMFpHjnA6UNruzkqlfsoTzwzYL0yow=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.20; Wed, 25 Jan
 2023 07:43:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%8]) with mapi id 15.20.6043.009; Wed, 25 Jan 2023
 07:42:29 +0000
Message-ID: <8d3e27aa-7b65-e08d-7dc1-a8db2d3f1389@oracle.com>
Date:   Wed, 25 Jan 2023 15:42:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 04/34] btrfs: remove the direct I/O read checksum lookup
 optimization
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-5-hch@lst.de>
 <1f02fc92-18e8-3c68-8a31-36b4e4a07efd@oracle.com>
 <20230124195531.GA16743@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230124195531.GA16743@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: c5182819-300f-481a-8ec6-08dafea7b5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbItAKvqHFSfH48ECnETlAw97bM0HXWnvoUsDZop6ohjNUagFA25xSDxSYMJY918EXh99uaqt24PESnX9louON5ZbF7CPZxZwWDAk9HuEj+aAqS0NaBBRtuthoiCnzLphLeWlUyzkzV6lyd1k7AihG+vu7jwkAfGIGD3TZRT38NUvC4QAc+oeGfMRMew5k0I7OxOZZSFMa9fc4ageeN1Kk8HguFhMXPCiqy19YNVFFxzdklkp6OtG4jcjunbNtl1mGrb9DAk+lPNUEzW7H4JSMkGWqrHRXoNKJ4pYjH4c7rKfSXFVGq5AQiVJ/+/K0p3Uw/9YMImgD6xTWMRwhrJ2zhkQLX1nuJkdNHlAePbHLy36pxqKOiVa5oh4A5PVK8Ji7vqrcOVoRcpPpndiwEGPwS6vH+YSlGZQ9qXmtHIHoi6OUhl3oCW2MvmIRUsdWAd18805gtXcJZAuKwZScj7ZYEu7b5cY3MjWcov2kxn9601/M7W+BYirTwjXeI5JG6Y30tkQj+Yr/LhVTeTa/fkmLdzokngeUUUS4Muj8+usylNUzkLIIvsfH0X2KtFItzZN7B1o5TPl8caHEaUMn4rSGSu311skXNyqyeKSKRorP+ys4axyako4pA02ZAHYh+bNXCOuoW0bdMfclAy4s6af/gWBKg8De+x3xqI7UlPsw4XsZv4OzICDI4t2hrubJSnw03HBAfLVGRZM56h2F4PgNm8oX7ZEo6D1wWQV+7RZv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199018)(2616005)(53546011)(6512007)(26005)(186003)(6506007)(6486002)(478600001)(66476007)(19627235002)(316002)(54906003)(66946007)(66556008)(31686004)(6666004)(83380400001)(8676002)(6916009)(4326008)(41300700001)(5660300002)(7416002)(8936002)(44832011)(2906002)(38100700002)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDdoZEVKVDJnaC9SM1g2YVdRYTl5YkZubmRSMFk0TktFQmY3N0NMbUVra1Bp?=
 =?utf-8?B?eUhHakRMSitreGpRNVFrUTFrK0xRRERLdElMajNNZ3h0M0RSanIvcjBrZFRV?=
 =?utf-8?B?U0d6c1ZkMjBlRjZBcHJiVTgydDlNRlhsTDNzT2R3KzZrekJUenpKVFpGUmlB?=
 =?utf-8?B?S2VYcVJZM3JYR1Vya3A0UFh1RnFUUm8zRWpvak5QVktZYlNyY2dPWmpETEtY?=
 =?utf-8?B?bDFHWnN1NmNkOGRLelQ0L0UySGZnU1JxM3h6ZkRPS3pWbVdieEg4U2x4UjN1?=
 =?utf-8?B?ZVRlZUhIN2hiRkxUWktKUUgxWTQ2NWhFTkI3bFdFaHVlOWd2Y2JYUVFBSXZP?=
 =?utf-8?B?NDFzQ3BPRW44Z3RGeTRPWXRjSjNKakZSTEJ5QUZHUVg5TkhpZW5OZ1RidGQ3?=
 =?utf-8?B?U2RsMkpNaEFGaXhaZXFXd244Z0R3VjRveXVuWmsvNWw1M3VwRUlKQUtnd1Fs?=
 =?utf-8?B?eUNzYzZWSDd0SlFLd0JHZ2R0Q082eVYvaGlIVHBuWVVMcmJidldSMGVtbmI4?=
 =?utf-8?B?T3RhUzdGeHJiODJmaXFoL2NiODY0bmJrM056dExqRHVxUjUvVWpaMGd2OHNo?=
 =?utf-8?B?RUgwYkl2MlhMTHVMVWhIenFGWVNTMysxRjNPem5rZEdsOWhic0syS2o4aSt1?=
 =?utf-8?B?VGI0akxwdVNSQktIc3QwckF5ZlFjVjgwMEtGOEZDc2JIcC8wdll3LzNJdmtu?=
 =?utf-8?B?OGFMZ1FGSjFoOEx4MldBdVJrbnFUdEYzeUg4RVBSU21zZHRFRWtTRUdQNkNS?=
 =?utf-8?B?aWNQOHhPMXZyaDI3czBRRHhBMjhkT0xvckl4SkppenJaMjMyejhycjRSS1ll?=
 =?utf-8?B?MlBkN0dtbll2amN0V2pJMGoyY1dzRnJlbnBtYTZrL0ZmSGVFMWtmR1ZpR2xp?=
 =?utf-8?B?dEUxNnZyM1RCU014Z1dVQnJKNFlLcEhQRW5oYW1hRDNYd0svdGgxYWM1TWpV?=
 =?utf-8?B?SFRwNlUxS1dnRHE4ZUFFelVyTXZqYXpOYjhKWWVXYTIxRnFoWDB6Y1RGMi9O?=
 =?utf-8?B?SnlRb01TaE9PeXV4b2NoeTRuRHV2QUNiUGZSK1NxVGFHejMrWEtybExxWnRB?=
 =?utf-8?B?KzBMcnBRdWxLK3pOekN6bndlQjZIbjRGdUpIR0I0TGtsS0xWZGpDbHp6bDU5?=
 =?utf-8?B?Yk51NG5tU20wb0taS1FJa01oSTVJWlowZUcvWi9OODhzaE15bmVrNmdLYkxT?=
 =?utf-8?B?eTNIVUVJREMrN1RPSVpXMWhHbFh0ODBsQmZWa1pLVm5pM3FRbHQ3OGxmNnR4?=
 =?utf-8?B?VUFUSjJqMzR4VExEZ3VJRUZTZU9yaGorTllKUHRRRjJmTlNKTERHU0FjZFhE?=
 =?utf-8?B?d2tQd2ZRdjRxeldCSmxwaGYrUStaOFdLR1hrOTU0NjA3Vi9HZTVDZ3U5cUlN?=
 =?utf-8?B?alUybEFDbTJCL0pkQTNFL0RGSEE0aFQwU3o0b2tOWExDVWpIbitta1VhM29L?=
 =?utf-8?B?eC9EOGNwUzF6TUk0Zkl1bGY5Ky9yT3hlK05sczAwTjdmTWwwOVcxempIb3Vo?=
 =?utf-8?B?UDhyRnV3MHZYaGJCMUZvOE5sWEpxY2xobzJQVXNRYVF2SmRqVTBNYy93MjJ1?=
 =?utf-8?B?SWlld1Bqb1NteWVlLzVmNnVVTCsxRkRwbG8xTDdJbWgxOW5UMEFEd0xFckxo?=
 =?utf-8?B?LzZxMEMzTWY2UHVOMlVzZUZJa1lPSytPb3pmNVdRamNiUXorQnhMZ29BdkFs?=
 =?utf-8?B?bUNUdGdidllSNS9zRXNuaDJOWUxJR0dlanlVakk1aTdwWUpWWmpaZW8vMW8y?=
 =?utf-8?B?WmR0SGFKWDJDcURQRVpaSUF3Nm5vd2hqTnlnQ2xEN2l5bDBLcFdEOVJOOENC?=
 =?utf-8?B?ajg1amRyMjlyOVlaT3I4UDNsRzRKd0RnR1JlYk5VTXpHRTRaWk1ENzVyRm9S?=
 =?utf-8?B?MXV0RjZ6YnN0MlpIOTdOTE4ra2IrZjYwMnBndnNHL3YwL0xtVG1CQ3BaOFRY?=
 =?utf-8?B?ZHgrL3FDTGFuYmdpcUgxblhDTDFhVUxveGRDeVNzSFdjQ3lFTXJFVk02UUF4?=
 =?utf-8?B?eE5JenZCZE1XaDIybVBSeThhL1F5czJDcmdDKzRseGhELy9ZK1lIc0NHRmJl?=
 =?utf-8?B?b1V0TTF4SXVHMUNPR2M5SjBybVk5NG9LU055ekZpY1dIYnNTeVpRaHZ2NDFq?=
 =?utf-8?B?Z3RublM4NFgwN3BLeFFZczlJNTRBR0x1VENYdXNMVDFRYWVjSmZaUXo4cnYx?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UUlzMkw1ZzFDc2hGWC8rM3lqNEM2cUthWk9ZQUFHTStsQndmdzRZMm94WFJP?=
 =?utf-8?B?K2l6YWhnVTQ3b2ZkZzRwc1p2U0dEV3lEVGlCclRHeEtRK1pOTXhtcWFIUWRx?=
 =?utf-8?B?bDJmVWhvWU1zZ0FaV0QvV1ZQK1ZVYWU5Um83UzR6ck5rVFoyL3BVVERvZktI?=
 =?utf-8?B?WjBCazk3Q3o3bjNmNXhJbU4xUGNFOGIyYTdVenhaU0ZiKzEzajV0aHVpNUNJ?=
 =?utf-8?B?dTVrWm1xTHpNYktuU21TY0xXZEJtSC9zbW9BUGhFb0wzNmFEL2duQjRoUmlE?=
 =?utf-8?B?Rkt0QWdpN1RJcGtGSFlYMjhOMGlQUVNoSUJRSGdINVU0Q0d1bGkyWEZUcTB6?=
 =?utf-8?B?Q3pvcGVlblRuOW9kZUNDK0g1S1lIMUM5QTlDZ3d6blNjSEdjbkRXTVZjUVBE?=
 =?utf-8?B?SHBZY0UrVmNwQTBXcnY1ZnFsMk91amNTVTQ2OVhPcE9tZCtidWZJeHozdE8v?=
 =?utf-8?B?RStJN2FUQkRnbURTbVZHc1RTVW5zRUpjczFTdXc3TzBpekpmU1RBSlg3WmNl?=
 =?utf-8?B?aDFoeGF5Qk5lVkhsVDlLM3l3LzBPYVBtajY0U0RXVDg2YTRmbXpGQ2ppOUZP?=
 =?utf-8?B?dVpGQTdLbTkrLy9zTFNqTTFBZkFBdEtqTFRRNkZkbkxvYjZOY0M4S2Q5RVh4?=
 =?utf-8?B?bS9wYWl1MjBhT3FhS3BodmYzbVhEakp2c2EwNy8xdEIxQWEyZndXMkFzT00r?=
 =?utf-8?B?TjhuR00vT0hCZ01QWFIxRHdGOGdSMXhaRFhkNEVDMnNjblVDaDZ0QWwvUlBy?=
 =?utf-8?B?bTFkVHpnK2tqbnVaN29rUHJQUVZkSHJ6WkVEYVFLNVdpYzZIWHhSQ2NQaHZ6?=
 =?utf-8?B?VmVLaWcxTVl3eE1hMXppVVowcXdscXVadHJ1SS9GSWZ3NUJKcjlNTnZZdWxs?=
 =?utf-8?B?VUlNNUVPVW42b3pHcGo0amJOQ2FubkpkRHhUNEQyQTJIV210NllkUDh6NVlw?=
 =?utf-8?B?VnMxYkFOd3hpQ1VHbi9XY1FLdlR2VkZYaEVpWWtMRTBYZnE5NFRtSEVvL21m?=
 =?utf-8?B?N09maUE4dEZjUHV3U3BBWHlwejRWWTJxS1R4OHVsWUxjNGNNbzRENDRCOThk?=
 =?utf-8?B?Y09ZUDVuYlY0NDNVUmh1bUd3ZWxlSHpTbWdkemNINFV0WUZyRytRTUhwd1Bh?=
 =?utf-8?B?b1FEMjlYN1BSVlhBVmtTazhTWjkrZVEwTXNnMTJHNTlFVmwyRytlby91VGtT?=
 =?utf-8?B?TWx3Rjl2NTdMQ29xclJKNkVyQVNGQmNkdU5ESkVxeWNnaHlobFN1QnZSK1Rx?=
 =?utf-8?Q?5holNxAsGtJYpER?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5182819-300f-481a-8ec6-08dafea7b5d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 07:42:29.3045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2dsYAT2vjk1eepxOg6Z3QESYehrgPdkMFQB5YRTnFcldb286H1mWlpPhguY8ZgDW6XpQgmyUcUwUpwI9TQ4cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_04,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=853
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250071
X-Proofpoint-GUID: c7lO5W_n9AEYPsRML2pUE4uMDgulbm6t
X-Proofpoint-ORIG-GUID: c7lO5W_n9AEYPsRML2pUE4uMDgulbm6t
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 25/01/2023 03:55, Christoph Hellwig wrote:
> On Tue, Jan 24, 2023 at 10:55:25PM +0800, Anand Jain wrote:
>>
>> I was curious about the commit message.
>> I ran fio to test the performance before and after the change.
>> The results were similar.
>>
>> fio --group_reporting=1 --directory /mnt/test --name dioread --direct=1
>> --size=1g --rw=read  --runtime=60 --iodepth=1024 --nrfiles=16 --numjobs=16
>>
>> before this patch
>> READ: bw=8208KiB/s (8405kB/s), 8208KiB/s-8208KiB/s (8405kB/s-8405kB/s),
>> io=481MiB (504MB), run=60017-60017msec
>>
>> after this patch
>> READ: bw=8353KiB/s (8554kB/s), 8353KiB/s-8353KiB/s (8554kB/s-8554kB/s),
>> io=490MiB (513MB), run=60013-60013msec
> 
> That's 4k reads.  The will benefit from the inline csum array in the
> btrfs_bio, but won't benefit from the existing batching, so this is
> kind of expected.
> 
> The good news is that the final series will still use the inline
> csum array for small reads, while also only doing a single csum tree
> lookup for larger reads, so you'll get the best of both worlds.
> 

Ok. Got this results for the whole series from an aarch64 
(pagesize=64k); Results finds little improvement/same.


Before:
Last commit:
b3b1ba7b8c0d btrfs: skip backref walking during fiemap if we know the 
leaf is shared

---- mkfs.btrfs /dev/vdb ..... :0 ----
---- mount -o max_inline=0 /dev/vdb /btrfs ..... :0 ----
---- fio --group_reporting=1 --directory /btrfs --name dioread 
--direct=1 --size=1g --rw=read --runtime=60 --iodepth=1024 --nrfiles=16 
--numjobs=16 | egrep "fio|READ" ..... :0 ----
fio-3.19
    READ: bw=6052MiB/s (6346MB/s), 6052MiB/s-6052MiB/s 
(6346MB/s-6346MB/s), io=16.0GiB (17.2GB), run=2707-2707msec

---- mkfs.btrfs /dev/vdb ..... :0 ----
---- mount -o max_inline=64K /dev/vdb /btrfs ..... :0 ----
---- fio --group_reporting=1 --directory /btrfs --name dioread 
--direct=1 --size=1g --rw=read --runtime=60 --iodepth=1024 --nrfiles=16 
--numjobs=16 | egrep "fio|READ" ..... :0 ----
fio-3.19
    READ: bw=6139MiB/s (6437MB/s), 6139MiB/s-6139MiB/s 
(6437MB/s-6437MB/s), io=16.0GiB (17.2GB), run=2669-2669msec


After:
last commit:
b488ab9aed15 iomap: remove IOMAP_F_ZONE_APPEND

---- mkfs.btrfs /dev/vdb ..... :0 ----
---- mount -o max_inline=0 /dev/vdb /btrfs ..... :0 ----
---- fio --group_reporting=1 --directory /btrfs --name dioread 
--direct=1 --size=1g --rw=read --runtime=60 --iodepth=1024 --nrfiles=16 
--numjobs=16 | egrep "fio|READ" ..... :0 ----
fio-3.19
    READ: bw=6100MiB/s (6396MB/s), 6100MiB/s-6100MiB/s 
(6396MB/s-6396MB/s), io=16.0GiB (17.2GB), run=2686-2686msec

---- mkfs.btrfs /dev/vdb ..... :0 ----
---- mount /dev/vdb /btrfs ..... :0 ----
---- fio --group_reporting=1 --directory /btrfs --name dioread 
--direct=1 --size=1g --rw=read --runtime=60 --iodepth=1024 --nrfiles=16 
--numjobs=16 | egrep "fio|READ" ..... :0 ----
fio-3.19
    READ: bw=6157MiB/s (6456MB/s), 6157MiB/s-6157MiB/s 
(6456MB/s-6456MB/s), io=16.0GiB (17.2GB), run=2661-2661msec



