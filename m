Return-Path: <linux-fsdevel+bounces-11801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D30857334
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 02:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B792A1C21325
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA69812E67;
	Fri, 16 Feb 2024 01:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U1I8HQ+v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b2gcmpZL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEC7FC0C
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045613; cv=fail; b=U1QhkAAvWpQ0kceYqM+UoOmWUHqpVi3fp7d07ETRhhRM6IUiX0ztFUH9DWFTTRb+uAYhBbA+7JOoM7UYlWgndA9mTbP4AKEvMAqGMS9Fq7TGbu4KzGt7QiQNnTfVNhI5EZbk9xFQ4lOT0P4C1RtCNRGBlfmHL6ODdjKxacICa/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045613; c=relaxed/simple;
	bh=t6y9grlnG1v80tYvnG4E74Y1jMVV0Ns66MRX13iLt3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N/l74pHLX5IIY4gLa9A6/Zt8933LegIG7DcL7BW9BUbpJ/0dM7hjs68RLmhJRqW8s0QaT2IPrlqnBOMlv3KESJDVsFuDwOvtmwgbvaKzsI1YdTsRek21KaqKHXiYFfqk1iEyAbpl+SyBsuGsiyRvkIR6esOEqWxRpvyAEagA3dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U1I8HQ+v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b2gcmpZL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSOae019795;
	Fri, 16 Feb 2024 01:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HPDKXh5evGYZfMnpvY/bZR32KDcfNonBPlyMIabDBpY=;
 b=U1I8HQ+vyVQdjftDyyRYSL8MMvS2TK1DSSp+O5wb4IIhXC6m0XQIhK9ns19bLnV4ZDmb
 wp3DUmDtp16bqsWHoXqUi7K9nb8n8z9d57OpmJPyGsNZw/PxYqQVl21ZIGQswpC+sBNz
 sH7p78WbzwiCVldPDWHm60oMx+OCPbwS9wj98le998SE4cmvLor5GybNZlI9ICiBtT/H
 tJwh6gnu1JW50NvCKppxm/4VtJwy6ryYx2/T05vwPcycYVCo8qk9U+cFHm1ZNwh7UVd4
 J8091JO1ytFftDZnG2JEQ/xZI2pPRJ0oIW4W3kYz4wRDZcUh6O/4lPHfL2iKRUJS2zdq DA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w93013q6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 01:06:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41G10j8M015104;
	Fri, 16 Feb 2024 01:06:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykbd6px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 01:06:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFNsWI2YwaweqhxFQr5LVNskuXvNZrc4gWY/UdjrfageP3+I6aytHA/wlPrN+Hknpm9FtREONRV2Hz4Tns4WQ5vh3Y8aqIe4/+i/GorI8h55GjQKQ5qGhUrg/cB5yGl/jU3QzbHEonKk6DH+H27ENIv3d6HvB9WEUfbYg1Nda1ux5MUi6RrfHZ9/VmszCkwZVmkiuuz3r9Y1Vz62NnBkLuEsz71L8N+0/CjVPVerbcDjBcF8A/LPNbC28L2A/c6NTMb6gRmrTx/5d/ZWaK1BRCtq1n/c6+o7RzIuSY7gWHKNgHM5HCAXP5f9h4LXoSgzDpfrdDj2LPq63kH3K6HBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPDKXh5evGYZfMnpvY/bZR32KDcfNonBPlyMIabDBpY=;
 b=Hq4ayzTVrkdFaU7GUUdIIpOJLQL58+R8tufZ3zWwFPPbYkrAUsslwETJd4pd1Oj8jlu/wmlYMmg4hHylZ69pG9bwT/T7iRW9QYfA9sE94wsBmaNK7ywanoqLmrPf8WG1nVv/b3sMT19lzVHirxypakXhlJbbMfrLbe0Wa3cNZC98lZmoFo5Jv6L38E0GMqexadhJ7sFSwWknjyulqcwZ8SN9EZJS7sWEym0zY7EaVC9Niy0aGA1m5kJ2mMW0rArwU/mmmQA6d+3fgLzxEP0sucrdvHzGiADHqLkuD8A7Y0HofQCleWZJpJL4v39JKqcIGqBu5A30k/B4vOZFTBzayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPDKXh5evGYZfMnpvY/bZR32KDcfNonBPlyMIabDBpY=;
 b=b2gcmpZL2EXE8jU3PeFYM6YW3CYSEAvTpKlnZI/gRYzdHiiM6/zNmO+mh/q6ziRWYG0awn/g0B3gcQYdD+C+RY20+MEAXBr/nTJ5iAohTFKmP7CYkiqEGiYvrhKcbLwUWQ9SOINyzY84f/Q+DXIBXyUAkqzMfJLpSU1JASWW3v4=
Received: from CH3PR10MB7959.namprd10.prod.outlook.com (2603:10b6:610:1c1::12)
 by PH7PR10MB6153.namprd10.prod.outlook.com (2603:10b6:510:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 01:06:42 +0000
Received: from CH3PR10MB7959.namprd10.prod.outlook.com
 ([fe80::284b:c3bb:c95:de8b]) by CH3PR10MB7959.namprd10.prod.outlook.com
 ([fe80::284b:c3bb:c95:de8b%4]) with mapi id 15.20.7270.033; Fri, 16 Feb 2024
 01:06:42 +0000
Message-ID: <b4b29ce3-36c4-4422-8346-842322b47516@oracle.com>
Date: Thu, 15 Feb 2024 17:06:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: Improve error handling
To: Damien Le Moal <dlemoal@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240214064526.3433662-1-dlemoal@kernel.org>
Content-Language: en-US
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle America Inc
In-Reply-To: <20240214064526.3433662-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::23) To CH3PR10MB7959.namprd10.prod.outlook.com
 (2603:10b6:610:1c1::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7959:EE_|PH7PR10MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba51e4d-e233-4658-9382-08dc2e8b89b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RtBM17MG4LmkrUfuAO/1OfKHj8OHmA21JfPrIxokKqk/2CAmtNRNRFsSU00Rpb+NrgOqJtxyOHhtH6GPtgLJe3E3jf8jguy+y0Cb7J/mzAgKUmgtuB79Idg+lZD58b4B8ecz1+JvcHiZF1vDEZaJbz/kePwpeCSszNr52l6q+4ZiGJYTBwAm7Wy0SOxeyg/XpVgl0tBcIaGRIy+3Z59aGn08NJjUEU4qA+5VcY86NW9vrms9FLTR45z/O6CcJJlSaI2qUt/GjAgZsV7XCqm+Awk0h2JOM7R6Uus+po4u2zAe2oOaL4gn99BqlLcYO58MvOafHGmvu/ZE804QShjfSQcPJOvT4zBN31QcTENJ2ym/G5NKOQ8nl/6F27VxArESmq9omRCRBm5hMplnFZk2p3/9d2S7akzquUZBM46rTxLGEP+Blg0chBxtz3lk1dhwR9g7/tyrSeeh/k5RZnUChdyYf80w+sb/0jiamt3gr6lnIfs14BZdig4MJeGBbSsOxbwHg1Jea5yo5ASyhVHrAfbUXMsCRvv0MZfTMsqtXp0o/9LHYv48mauBxtSCta7v
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7959.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(53546011)(6506007)(478600001)(6512007)(41300700001)(2616005)(6486002)(5660300002)(31686004)(36916002)(2906002)(66476007)(4326008)(8676002)(44832011)(66946007)(66556008)(8936002)(316002)(54906003)(26005)(83380400001)(38100700002)(31696002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZE1xZUk1Q0lCNWs3cU93SUhmbVNjUEhDQkRCY1VTTFR2aTJTRThSR20vWmM5?=
 =?utf-8?B?bi9nejArUzY1VVV0SXZiTkRDMStoZU1BYTJOTW1kdUpYMEhYMG5senJkbDRQ?=
 =?utf-8?B?UFY4ekE5dlR5L2dFeUZLKzF2Y0RlMDJmczZMSGFVcVIzc3l3VzQrWjVwU2Fq?=
 =?utf-8?B?SHpSeVFNYVdDbDVnbTZSczVLUUt1c2wyR3ZvUFMxcUNjd0RCWlpuU1FDb0dm?=
 =?utf-8?B?Rk1NQ21sTVEzU1dtVTRuRkczT1ZnNGxJWHlzT0FIenpLckJJeWNFTWFvTVlr?=
 =?utf-8?B?eGF1aGI2SCtSTFNPNGVmRWgzbUFQUmR2Wldqd1VYdVJqS2Fvd0sxbWY5cDd2?=
 =?utf-8?B?Wlp5NGlOcC9lNU5ZbHdaeDNsTlFrbEVFK2cxVHVzOUdWZGEybmozWTVjc2Js?=
 =?utf-8?B?OEZ1K0xNa0FCNWx5QjNVdUJUV3dtNVEzUXgxQ2c0WnVYRWtmUExKK1FGVGZx?=
 =?utf-8?B?UUdMV3RBaXd2ZmJ2MnZ6SUZoamxDL2VlOVFTREVTYUI3UFdzU1huZTV4VFla?=
 =?utf-8?B?clBjdzNycWgrYlZSOFgreW9VUmw3eTh3RWZ4TTRZVnB1RXViQVg3V1FTcUQz?=
 =?utf-8?B?eS9WbzZ6aDI2YUZvK0E1NHQvQ0Z3Wm05QnZjbklRQ1ZnTnp6Uk9ZNUdqeFlt?=
 =?utf-8?B?MlBBYkVjalp5RVZIclRibmJMRDU3TllqODVEek5Ed3ZNUjZ0blRPZGl4TEhY?=
 =?utf-8?B?MDRURmlwUHpGTnluMmlhLzdzcjJYYXZoeEVqYVdqMGJyRG03WjVUaXk5TExx?=
 =?utf-8?B?OElDMDJIbmpBSnNPTGF1dWJrMWlzc3FmMk9wL05PQ3VaY2xTWHQ0N1RTMWps?=
 =?utf-8?B?NDN1RTFLWHFLd0hHZUVId1pKRm9TZUpjeUs1ZHFNQjNZeW1GQnVEREQ2VWE5?=
 =?utf-8?B?bVloWEpVRWRaT3FCZ2ovbmRSS0FmcmF6dzBMN1ZnTjJnRHpkcGs4ZjQ5aEhH?=
 =?utf-8?B?TGt2NzRMTzZvRkNvUm4reVhSNVI2b01mYURRdjFqYVRUUHNRM3pRTFIvRFNv?=
 =?utf-8?B?T1FKL01PcVJ0UGNjcTJwTEU3M0pXa1B2Y2dCVUEwQXVnc1AwbEpxR0JZYUR1?=
 =?utf-8?B?VktDc3FKamtFQ1RIR2VBeVVQK0w4VHlYRVdTZFlPVk1HaTBIYW9YUHFvMVh6?=
 =?utf-8?B?bWZacitoMHUrUko2aENJcVVUSExNbVo3V0NlMFB5L3YxcXBmb1l4c1ZubzFw?=
 =?utf-8?B?VU5xVUZFbWNhS0tMOSsxUGNCVFNzcHUwTFRKaTRyYnROZWxDK3FsT2VuQ0Zz?=
 =?utf-8?B?ZnBvTnEyY0Q3TW5DT0F5SHBWY2hnbmxFZUFyY2U5TW8rRVhWQ3pUcXhYalFT?=
 =?utf-8?B?MTlJL2YrbHNCM09KWGZ3ZjZIM0haSWNJanBtZCtVNDBOYjlkTEdBejd5cmNV?=
 =?utf-8?B?RXMrSk1JZFZKYjhhT0xIWWhRZHArenIxZDk3WGx4UGk2VVZ0Zy94bFVFdm5s?=
 =?utf-8?B?ZDRsUUx4eWlxVVBLWDRCZk44OVRKYzlPb3VpZWs4S04vWHFMN0tqeFdTUm8v?=
 =?utf-8?B?eUVwT0FTc2N4ZXU2bkgvZ21XMkE3RlIzV3VTNGRRdDZIRG1xcEtTVzFCVXh5?=
 =?utf-8?B?eFoySUVUS0NmUm4rdG1PeWZVREl0YlJmWkc0VHIrV09VT08rSXg2OEdFZmxw?=
 =?utf-8?B?UjlId3FyWVYzL3l2MVh4N2RzTVh0a3dIUE9xVXpPNWdYWWJzMVJzOGIvaytK?=
 =?utf-8?B?ME5wMXd1eEhyelN4eVVFMmpOSU5ZSCtYbkQyNm9Ec0hyQ0hmelgzb2pmUzNw?=
 =?utf-8?B?aEVHUzU2emczQlM4QmEycTBuNUlCSU1rbEJKRy9UQ2JsbGVRMHkrUGw4ZmF5?=
 =?utf-8?B?RXBjNVBqcGlNbmNkQSt6OTR1QkttRENUMEtsbmVpSEJXY2NoWkJuNHNibkMx?=
 =?utf-8?B?RlZrYXNPcXlEODlxR1NyYmhhS0tuSWdKYmxQNTJGZlZEaWxkTWVTYjVEcG5W?=
 =?utf-8?B?Z3dtZjgySXlKYmJPeFdOZmIySllyN0VMQXBEQk9FQys0RGZ4UzF6WER3MkpD?=
 =?utf-8?B?MzlRZ0ZlM3BXT0RKUjJackVtM3BmYW1nR0hsVUV2anhoaUgzMjA4dmx3VFlz?=
 =?utf-8?B?bWZSc1ozMEJHRnpQcExTUVp5dEhTdGNiV2JLaWFBS2F5c0sxUllBZUFObWVQ?=
 =?utf-8?B?R2djNWppaTNScjIrZXFwTkFYUEJXcTk3TjVBRTgrWXhsRjhzZUkyZks2djB2?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ghTdKhIIahU3HK4PxUuWkoa5veUikDOFH52WyHFZFbKPWHcbT1Fg4+Elb9q9lKqc+FGWkIr21RKVqilzGfpLAUU/kj3UNQwgYi7DEc5Ixd1IwihdRp74QUryOb/HiwdlFdMD624lL3N4sYHbb2rGQgQqJQ3GKYDm/djoKnXhk/+5B5f+e6wz2OMRpYcMQIbHgXgpnGN7bsmp2glGJ8qQeoo2InAeQzCytMLY20ZAHyVL2wwHxeImSQnO1Z89SluMyubEx8owiwdls95oyJ2Spdcdl1PNs0dcTkNobE/8gH/XX9/f55oGS2O66OSuX9flz5SZOKfbTNDWP1mT6+ZJpLZnTnGz0gcEmQPWAjXxmbO/PdhmuAHJJE69EtpvPIstkDBpBwjBFxm8yA/JBEBV2lC6DJx+6W8nG7KJzWm/VePC2hwbS4qxS4D/qp9P/0/yD5mTgvql4KAWE51zQmMemcht3oFN/GYCNJTDMEYP8SjxpMp9Iu1081g46iAnN0nYwOUojO9aaJMB7XVT02wdTuqVcVToClq4sHWZZqm8eHi8K9qgYi9X19TCn0vtZCwurgGdsyS/FKAuVCFUz1Q497juYm7HBBgkLSTnkKhMKJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba51e4d-e233-4658-9382-08dc2e8b89b7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7959.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 01:06:42.6469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLmgPjKWm2KrFtXXyYMHkijMA0CGzxrnyFgI+i7YQjQyUdhgTQFk/zZNmtnMQfEjxVu9A8+wWfpWce2Kkb/TkevOql3ALzorcxOMxyMZ9ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_24,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160006
X-Proofpoint-GUID: R6b_H1BCczU0U7X-Ho9bFW6H2TQuWmL2
X-Proofpoint-ORIG-GUID: R6b_H1BCczU0U7X-Ho9bFW6H2TQuWmL2



On 2/13/24 22:45, Damien Le Moal wrote:
> Write error handling is racy and can sometime lead to the error recovery
> path wrongly changing the inode size of a sequential zone file to an
> incorrect value  which results in garbage data being readable at the end
> of a file. There are 2 problems:
> 
> 1) zonefs_file_dio_write() updates a zone file write pointer offset
>     after issuing a direct IO with iomap_dio_rw(). This update is done
>     only if the IO succeed for synchronous direct writes. However, for
>     asynchronous direct writes, the update is done without waiting for
>     the IO completion so that the next asynchronous IO can be
>     immediately issued. However, if an asynchronous IO completes with a
>     failure right before the i_truncate_mutex lock protecting the update,
>     the update may change the value of the inode write pointer offset
>     that was corrected by the error path (zonefs_io_error() function).
> 
> 2) zonefs_io_error() is called when a read or write error occurs. This
>     function executes a report zone operation using the callback function
>     zonefs_io_error_cb(), which does all the error recovery handling
>     based on the current zone condition, write pointer position and
>     according to the mount options being used. However, depending on the
>     zoned device being used, a report zone callback may be executed in a
>     context that is different from the context of __zonefs_io_error(). As
>     a result, zonefs_io_error_cb() may be executed without the inode
>     truncate mutex lock held, which can lead to invalid error processing.
> 
> Fix both problems as follows:
> - Problem 1: Perform the inode write pointer offset update before a
>    direct write is issued with iomap_dio_rw(). This is safe to do as
>    partial direct writes are not supported (IOMAP_DIO_PARTIAL is not
>    set) and any failed IO will trigger the execution of zonefs_io_error()
>    which will correct the inode write pointer offset to reflect the
>    current state of the one on the device.
> - Problem 2: Change zonefs_io_error_cb() into zonefs_handle_io_error()
>    and call this function directly from __zonefs_io_error() after
>    obtaining the zone information using blkdev_report_zones() with a
>    simple callback function that copies to a local stack variable the
>    struct blk_zone obtained from the device. This ensures that error
>    handling is performed holding the inode truncate mutex.
>    This change also simplifies error handling for conventional zone files
>    by bypassing the execution of report zones entirely. This is safe to
>    do because the condition of conventional zones cannot be read-only or
>    offline and conventional zone files are always fully mapped with a
>    constant file size.
> 
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   fs/zonefs/file.c  | 42 +++++++++++++++++++-----------
>   fs/zonefs/super.c | 66 +++++++++++++++++++++++++++--------------------
>   2 files changed, 65 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 6ab2318a9c8e..dba5dcb62bef 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -348,7 +348,12 @@ static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
>   	struct zonefs_inode_info *zi = ZONEFS_I(inode);
>   
>   	if (error) {
> -		zonefs_io_error(inode, true);
> +		/*
> +		 * For Sync IOs, error recovery is called from
> +		 * zonefs_file_dio_write().
> +		 */
> +		if (!is_sync_kiocb(iocb))
> +			zonefs_io_error(inode, true);
>   		return error;
>   	}
>   
> @@ -491,6 +496,14 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
>   			ret = -EINVAL;
>   			goto inode_unlock;
>   		}
> +		/*
> +		 * Advance the zone write pointer offset. This assumes that the
> +		 * IO will succeed, which is OK to do because we do not allow
> +		 * partial writes (IOMAP_DIO_PARTIAL is not set) and if the IO
> +		 * fails, the error path will correct the write pointer offset.
> +		 */
> +		z->z_wpoffset += count;
> +		zonefs_inode_account_active(inode);
>   		mutex_unlock(&zi->i_truncate_mutex);
>   	}
>   
> @@ -504,20 +517,19 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
>   	if (ret == -ENOTBLK)
>   		ret = -EBUSY;
>   
> -	if (zonefs_zone_is_seq(z) &&
> -	    (ret > 0 || ret == -EIOCBQUEUED)) {
> -		if (ret > 0)
> -			count = ret;
> -
> -		/*
> -		 * Update the zone write pointer offset assuming the write
> -		 * operation succeeded. If it did not, the error recovery path
> -		 * will correct it. Also do active seq file accounting.
> -		 */
> -		mutex_lock(&zi->i_truncate_mutex);
> -		z->z_wpoffset += count;
> -		zonefs_inode_account_active(inode);
> -		mutex_unlock(&zi->i_truncate_mutex);
> +	/*
> +	 * For a failed IO or partial completion, trigger error recovery
> +	 * to update the zone write pointer offset to a correct value.
> +	 * For asynchronous IOs, zonefs_file_write_dio_end_io() may already
> +	 * have executed error recovery if the IO already completed when we
> +	 * reach here. However, we cannot know that and execute error recovery
> +	 * again (that will not change anything).
> +	 */
> +	if (zonefs_zone_is_seq(z)) {
> +		if (ret > 0 && ret != count)
> +			ret = -EIO;
> +		if (ret < 0 && ret != -EIOCBQUEUED)
> +			zonefs_io_error(inode, true);
>   	}
>   
>   inode_unlock:
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 93971742613a..b6e8e7c96251 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -246,16 +246,18 @@ static void zonefs_inode_update_mode(struct inode *inode)
>   	z->z_mode = inode->i_mode;
>   }
>   
> -struct zonefs_ioerr_data {
> -	struct inode	*inode;
> -	bool		write;
> -};
> -
>   static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
>   			      void *data)
>   {
> -	struct zonefs_ioerr_data *err = data;
> -	struct inode *inode = err->inode;
> +	struct blk_zone *z = data;
> +
> +	*z = *zone;
> +	return 0;
> +}
> +
> +static void zonefs_handle_io_error(struct inode *inode, struct blk_zone *zone,
> +				   bool write)
> +{
>   	struct zonefs_zone *z = zonefs_inode_zone(inode);
>   	struct super_block *sb = inode->i_sb;
>   	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> @@ -270,8 +272,8 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
>   	data_size = zonefs_check_zone_condition(sb, z, zone);
>   	isize = i_size_read(inode);
>   	if (!(z->z_flags & (ZONEFS_ZONE_READONLY | ZONEFS_ZONE_OFFLINE)) &&
> -	    !err->write && isize == data_size)
> -		return 0;
> +	    !write && isize == data_size)
> +		return;
>   
>   	/*
>   	 * At this point, we detected either a bad zone or an inconsistency
> @@ -292,7 +294,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
>   	 * In all cases, warn about inode size inconsistency and handle the
>   	 * IO error according to the zone condition and to the mount options.
>   	 */
> -	if (zonefs_zone_is_seq(z) && isize != data_size)
> +	if (isize != data_size)
>   		zonefs_warn(sb,
>   			    "inode %lu: invalid size %lld (should be %lld)\n",
>   			    inode->i_ino, isize, data_size);
> @@ -352,8 +354,6 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
>   	zonefs_i_size_write(inode, data_size);
>   	z->z_wpoffset = data_size;
>   	zonefs_inode_account_active(inode);
> -
> -	return 0;
>   }
>   
>   /*
> @@ -367,23 +367,25 @@ void __zonefs_io_error(struct inode *inode, bool write)
>   {
>   	struct zonefs_zone *z = zonefs_inode_zone(inode);
>   	struct super_block *sb = inode->i_sb;
> -	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
>   	unsigned int noio_flag;
> -	unsigned int nr_zones = 1;
> -	struct zonefs_ioerr_data err = {
> -		.inode = inode,
> -		.write = write,
> -	};
> +	struct blk_zone zone;
>   	int ret;
>   
>   	/*
> -	 * The only files that have more than one zone are conventional zone
> -	 * files with aggregated conventional zones, for which the inode zone
> -	 * size is always larger than the device zone size.
> +	 * Conventional zone have no write pointer and cannot become read-only
> +	 * or offline. So simply fake a report for a single or aggregated zone
> +	 * and let zonefs_handle_io_error() correct the zone inode information
> +	 * according to the mount options.
>   	 */
> -	if (z->z_size > bdev_zone_sectors(sb->s_bdev))
> -		nr_zones = z->z_size >>
> -			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
> +	if (!zonefs_zone_is_seq(z)) {
> +		zone.start = z->z_sector;
> +		zone.len = z->z_size >> SECTOR_SHIFT;
> +		zone.wp = zone.start + zone.len;
> +		zone.type = BLK_ZONE_TYPE_CONVENTIONAL;
> +		zone.cond = BLK_ZONE_COND_NOT_WP;
> +		zone.capacity = zone.len;
> +		goto handle_io_error;
> +	}
>   
>   	/*
>   	 * Memory allocations in blkdev_report_zones() can trigger a memory
> @@ -394,12 +396,20 @@ void __zonefs_io_error(struct inode *inode, bool write)
>   	 * the GFP_NOIO context avoids both problems.
>   	 */
>   	noio_flag = memalloc_noio_save();
> -	ret = blkdev_report_zones(sb->s_bdev, z->z_sector, nr_zones,
> -				  zonefs_io_error_cb, &err);
> -	if (ret != nr_zones)
> +	ret = blkdev_report_zones(sb->s_bdev, z->z_sector, 1,
> +				  zonefs_io_error_cb, &zone);
> +	memalloc_noio_restore(noio_flag);
> +
> +	if (ret != 1) {
>   		zonefs_err(sb, "Get inode %lu zone information failed %d\n",
>   			   inode->i_ino, ret);
> -	memalloc_noio_restore(noio_flag);
> +		zonefs_warn(sb, "remounting filesystem read-only\n");
> +		sb->s_flags |= SB_RDONLY;
> +		return;
> +	}
> +
> +handle_io_error:
> +	zonefs_handle_io_error(inode, &zone, write);
>   }
>   
>   static struct kmem_cache *zonefs_inode_cachep;


Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering

