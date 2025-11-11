Return-Path: <linux-fsdevel+bounces-67963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B030C4ED09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 16:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8873B57F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A9236997D;
	Tue, 11 Nov 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RTMoh1Li";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wRJsQ/h7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4CA2EAB79;
	Tue, 11 Nov 2025 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875272; cv=fail; b=ozRu+zd+8VQAI8IJuCBrXyI/UNWDNVeopeCLI0GgiHpdfbzwQdzLAt1KbYj48JskSj9u438yZUbszcz62NLo6p+XUyEDB1yxgP+qMg2aZbcObtcKhsqZHWRp9PKUsCulZ3D17gQTXdyzBU4bIVPWHrU8lf5cioGRejdHS4ZGTzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875272; c=relaxed/simple;
	bh=/EUh5yzUOBuTqfuKGcvwWqPiPNtZ8q8I+fCH8TaWYi0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jKg4pwMt6WkhMqpmBrCG/oT495EnjnRRurUwRrlg1iuVTeNnE0I0kZEYUdofMq+S9XZKbQ/7lw3jnlLt23WIjsLItj/qOaHSDq8yXf4hevRsDSlBb+70l0ehGnkOA66B14Vc6PE7wlpHSb4bmA3cYn5WSo65yqHvpwoi+rmrTEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RTMoh1Li; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wRJsQ/h7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABFNakC018069;
	Tue, 11 Nov 2025 15:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GLqAyn2QN8SxUl0O2TRfkOIJzirp56Ln+37AvmAauAw=; b=
	RTMoh1Lii0+ozdo+Hco8KjzBteeNDFonfc4l/D6vbzxWRLWdFVHZovX6P5ZxwqAP
	c6Pw4JsuWp8CBNHg/Pr4o5a+7hm9FxDuSWFX22h9ieiCJiY2TzoDCPyUlVCsbnqn
	daerV4VkVbxK4vTP2NNQCug9ZbfVweFBqEIpH5b0ffK8nvxUaPm+PRY7uJuoazUK
	/xU2sNzKJ/47FWsmsqrTjk7drs9PGjBog5xpnszd8U8OZ4vOXQzvPArhc3utW8t1
	xKNxQpYj0JvYO/Pqehx06WkGpRCBGHsrGM0JuWXiDztFuIqX4TsmBtFILPIvgPxk
	EjZtAIMyfnJFxyimarQ7BA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ac54p0bwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 15:34:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABEhgGj007466;
	Tue, 11 Nov 2025 15:34:13 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaa5y13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 15:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QArHTeULhmFVOAvNsIM0UFzKkvrYv5UGg7auiGbWJ/NOJA24/yplGJvrv5FJk3xOK5rPDdKkr3ki9UnksGeAQEvmXXTSwg9AoCb79s6OziE+whh++Lt5ule2eNScpo/HGGTPOC4RuZsr0QX1j97tVwL6tZ1LBQfroKMbhFpHcGhrKhU+0vErLgwWqSpdkrmHAJ5E4AarniDKf2c6n9l5DKA8k6GPJ/llevLKJwjzJoDUTHqXEnHTI+s8sn0h91/JIDfHRp9mC81SbuhN/N4cf+IbM+4Zq6PRIsXzL4U2ZHsZFqe2IrtiYyFU9txyzoef6zKHO/XA4lfzxf2nuMEOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLqAyn2QN8SxUl0O2TRfkOIJzirp56Ln+37AvmAauAw=;
 b=CRvWnLcqWXylsF6Yfqy3pBeKzY9oZKoGP0P0z+oxHK2Tnqv+7QaleaGzk9PKBBbWyInXrpJRLpwFsbKL7IVC7gOKKaoltclRsks5YkQrfrcnQx+51mQEaBBOvb0Z958Z6AlGzb/7nI0e5z9FY3ILwuAiQtPcHgFzfLjTtVSCD4qwKvOhQvzMvBschIVQQrvz7vDBvEWIijz7E5JNTGA3+iI/GBHDlhlSCD1oLJg//MkK7hiyo6mZMRCdrLYESWkZZ5oVP2HpqTjQgxsSZNZuIt1F7uOtOJEavY/3lVxS+d0ji2pHFCuAlEkf6ae6USsaRFFOOWbF/YUwn4354jmXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLqAyn2QN8SxUl0O2TRfkOIJzirp56Ln+37AvmAauAw=;
 b=wRJsQ/h7vJCtHNeyRvlnXrNid5L2qrBMNalDAvrLu5q9XYNs3vTZI9ss8tfrqe1Q2zWvPR5YOYaZKQdLkzVZN0MsX7ihmdA34EjSIn8zjNuUtG+qDJwDhOJKa0Nr7HWK8Vra/O5feQTtOHZAhZZQeL6F8Ggby++By/igxfNbFB0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA4PR10MB8636.namprd10.prod.outlook.com (2603:10b6:208:568::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 15:34:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Tue, 11 Nov 2025
 15:34:06 +0000
Message-ID: <5f014677-42c4-4638-a2ef-a1f285977ff4@oracle.com>
Date: Tue, 11 Nov 2025 10:34:04 -0500
User-Agent: Mozilla Thunderbird
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [Patch 0/2] NFSD: Fix server hang when there are multiple layout
 conflicts
To: Dai Ngo <dai.ngo@oracle.com>,
        Benjamin Coddington <bcodding@hammerspace.com>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        hch@lst.de, alex.aring@gmail.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251106170729.310683-1-dai.ngo@oracle.com>
 <ADB5A1E8-F1BF-4B42-BD77-96C57B135305@hammerspace.com>
 <e38104d7-1c2e-4791-aa78-d4458233dcb6@oracle.com>
Content-Language: en-US
In-Reply-To: <e38104d7-1c2e-4791-aa78-d4458233dcb6@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:610:4e::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA4PR10MB8636:EE_
X-MS-Office365-Filtering-Correlation-Id: 2199e59a-74b8-4685-553f-08de2137c05c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TmVsMzdGUFFZMXpvRUFtd2YzTDZRNEFZbW5qVytqWTFzRVBuMDN6ZUtVeGtB?=
 =?utf-8?B?OE5IWlA5NXlrYTkxM045RzhqYXhNak93SVhRZURCR2Y3OWxOenNOUVVsTEQ2?=
 =?utf-8?B?ekkyK2FFZnZiY1drZCtpeXAxekxrS3g2Qkt1aGJuSHhqZmVGWkp4V2tZS0Qy?=
 =?utf-8?B?ZHI4Rm9nQXl4eElOdllZSkRDWGdtRjZwVnI1RFFMYit5Mk5DVkE4OGlodG83?=
 =?utf-8?B?RkN0UGFXSW9qblM1TUJzZjZkZnVZbS96WEZSM3RYdzFwU1lWUzNhMmd1c01U?=
 =?utf-8?B?OEFFc1BDUG94VTVsWHo4OGVmUy9nMzBBbWREQTR6NjZyRUd1SHRzYTlMNFND?=
 =?utf-8?B?bUNwSzBtd2gvQisxaWxtUjQwMzkxS0QwRmxaN084NHpZSEdTdlc1c1BESFo0?=
 =?utf-8?B?Nk9aN2pqOFpLNVpiVi9QV1FiWC9GdUY1RzJ1clQ2RDRmV2ZOb05KVFR0M3A1?=
 =?utf-8?B?WE5ZVWpxdUtTbU1KaGN2MDM5T3I4dEltMXFKZG80VzJ4L1JwbDFEa1JYQ3pY?=
 =?utf-8?B?eUtZdDNMSzlBZUZCaXdUaU93cWFiNTlmeFpNZHlwRWh2REloaDlzUmJVS3py?=
 =?utf-8?B?YVk1OUM3ZkJuVWx5OExtdmtXUWlndmQ3TG1rWFZGaG82RTRGTE9HdmdXaExl?=
 =?utf-8?B?YlZnU3QxLy9DNS9ES1BhaURFZ3lid0ZLMVMzWndkRnZ0OTFXWmN5b1VIMU53?=
 =?utf-8?B?bG5KWk5xbDM1WjJDNnFzQ3NUZUpiUWZMR3lKc012dlU4dzh0ZW1WVEV2S2NL?=
 =?utf-8?B?WTZsWW1CV2U0R0ljRzhrVVhVS0ppT1dDRmFFaGxBMyt1cmU0V0h1MXBZVzVr?=
 =?utf-8?B?L3dnVHpOSkkvNWJ6Ly95Znprcm13Y1FoWWdITm56bSttYVpZQlNGMi9ZZlpH?=
 =?utf-8?B?VVpaSGMwQ3pSQ2JKYWFEL2ZpQmMvMWZQK2JLNUlPZTVCNDlTdk9EbE5keEpF?=
 =?utf-8?B?OHFKMkpSMi9WUGhjZkxVb1pNNUl4YVA4ejlpSmZhL2VuRmt1ZXh3OFYxdExF?=
 =?utf-8?B?UlhTVkMxVWQ5Um5KZkN0Y3FWdDFGMTBmVCtsY1Y3eE44YXJteWkvZXVyRFZj?=
 =?utf-8?B?a2pGdUNPWlVYZFVEY2FkNlpUVTVlK0Izd0g1TDN2RFBPcC8vZ0JraWx1TEJZ?=
 =?utf-8?B?aXlrb1lzWnRqeTV5cGk5TUxCemltMm9teUk4KzIwWXRWeG1qUHh1ekFoRitX?=
 =?utf-8?B?RTFqa2ZFamtaMVBlOHhMYmVsWUZJTEkrcm1MTUxvWm9BWTdobGx3M1F6REFq?=
 =?utf-8?B?OEIxeW5HZW1QbnJqWGo0eUpFOTltM2pONmlFaERtZEhNL0xxeHcrQ0drWjF4?=
 =?utf-8?B?dVJ3OVlFM0NkbnFFdm9hSTdJaWkrcUJQRGlZNnpJV0JYOHpkKzUzM2NrNUVR?=
 =?utf-8?B?SWw1S0tYcmUrRlJtYlV4aUJ2dTRraWRLL1NNZFdPbkpDalY2YkQ5RGVzcGQy?=
 =?utf-8?B?Q1FKVm9zd2ozQk0rK3ZMY29oVjZ0VlJvTTM1dzQ2VHBRdEp6TXRib0UyMmx6?=
 =?utf-8?B?a1g1bk5KUlB1eGk2ZGVkMEtZZmh1bTQxT2lPTzNHalRpMVpNV0x2NkZRZUtP?=
 =?utf-8?B?UVU1bjcvelJSL3k5M0V1Q0EzR1l6ZnlSMW15ekwyZHBaZTJnK1RsTHRMcWw5?=
 =?utf-8?B?RWI2UTdWUVFEU0lGeDA3cFBvRnVEYVkzRlVNdFRQR1A0QXFza3A4RzhKSTRr?=
 =?utf-8?B?ZE5IZ3hLRytBWHl1UVlwcjBuT3NlemJnUHRJamlpU2xKOE1hdmlpZW9uandB?=
 =?utf-8?B?aG5GbGRkYUNkdURkNHJWTjUwOFJhaTRHWi9LRno4T1hVWDcxZllLR3BEOEZS?=
 =?utf-8?B?TkxtUE4wN3NjNE5YNXk1ZGsrVTBGQlk1dkNWT2VIM2U5UFdwNVNuRzk1ekU5?=
 =?utf-8?B?Q2NPWUZrb3pDZGh6ZE9nSnFVOW5ZbnJ3UHV0UnNCSHhKY3M0ZnZkcHF0Y3V3?=
 =?utf-8?Q?EbyvmTu8V2tz/fYDkKEY3yoTFPfI9tOc?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RWcwSkx6ekdXS291TUV6N3Y0Tm9JUDRTYVg0b0NGSnhxVkZmWUQzUWFtSTBO?=
 =?utf-8?B?SDRiOXhQZkxKMWZuT1o2Si9NZEY3L0hqdXV1Q00xaWFBUHh5NVhnWG1sZy9Z?=
 =?utf-8?B?cXF6OU1xRzZGeWU5b2JJZE1NVEg3bXAzSnpWbGR5WW4zM0RLcFMzQXdELzAw?=
 =?utf-8?B?dWYyMGxyVVVKRlR4YlRmU2NrUDUrV1pKdlh4aXR0ZU00eGdxb3A1NERSdS9Z?=
 =?utf-8?B?Y0ZNSzUzc2xZNldIZEhrZzZjc2I3bDQ2cW1uYWE5UHRpTjBVYW9paGR0bFRv?=
 =?utf-8?B?Sk53b0JVZ0VPS0xNVU8zbEVjdCsvN0tzWEdXQ242R1hZNU5JUjlxRFI2b0FP?=
 =?utf-8?B?clVEUXVOOHNEd280MEgrU1d4Y3FlZE9JWjg4WFowSUFIRE5hWGczNjhSc3Rv?=
 =?utf-8?B?TGpMaUhDMEpzbUpaaGxaclpXNG5nREkxNUU2b21TNFB0ayt1Z21YRXo1aTNk?=
 =?utf-8?B?MGRJQjN2Q3BkS2xuQkQ2dFZjZFNCN2xCajNjc0FGV2tUcUJhdjU0clFQendH?=
 =?utf-8?B?ZHo2UkJld0lGcUpyUnZxWFJ5UkFwcXlBM3psajZwc0pzckNET0wxdkxHZlF5?=
 =?utf-8?B?M2F0YWFGOXF2SmtjMHcyZm4xdnZleStFdzhaUk1BUEE0NDhob3BNTlJMQWtO?=
 =?utf-8?B?YjJDSHUxRmpNWjBWY2c2Q0J5ZzhVTVRKYzZMK0k2UngrQ0MzNHNGZjY3WGpS?=
 =?utf-8?B?UnYyQnllbjZvT2lMZkF0ZiszRXFIMlJSY2x2Y1U4ZkZsRk1PMnlzb2c2TjEw?=
 =?utf-8?B?UHhxQXZKMmE2TlZVN2xiMkc5OUhQSkd1NTVtdmtncWY1emcwcVlPUjJnNDIr?=
 =?utf-8?B?L3BxYU9zWkJFWjdTSUQvUlFWL2oxWEVTK0dldFVTc1U2dlNXYnJhZjY1NzZO?=
 =?utf-8?B?d0lYYWtrVVIzMlJJN29nRFIwd2VJdmJLUmQ1YThUYnd6ODdkOHltQ2RxWCtS?=
 =?utf-8?B?blhSUWM5c1hUMWNPU2VUcmdvaENIVURRZS8ybTZ2ZFhOTC8rcmpoVTZIVm5s?=
 =?utf-8?B?bUFMQzRhbGZYQ3pWRnBid2RmRWY3WTg5OHhpRkthKzlPdUJuM0pxZHBMNWk2?=
 =?utf-8?B?NElaSzB4TEVFVzhPZ0IyRmFSb3QrejdTbytBQjB6bVV4YXBJNVc4KzlxUWl6?=
 =?utf-8?B?Q3liNjFPNnRhR2crL0lJaGNZUFYwQVEzTnVPaDVQemZpcWxDSVBVakZpbHFV?=
 =?utf-8?B?SlR4ZEZGeXkzY1d5b3NxVHlvSzU5M0VMWFVsTE5adEFENU1Ebk41VURrNFM4?=
 =?utf-8?B?SFA3N1FFYmg2N1V5OFJlMVRwTUZtSk54ei80aURBQk9zZXFaM0JkM29PYnJE?=
 =?utf-8?B?QXhBcS91MnA5YVZEZHdFV1lFUDhtZW00VmJiMDFaMXRocW1HcVJKeGtRUFE0?=
 =?utf-8?B?MllIODl4QTAvUEZ5YWk1TkErcFNWaDd3cW1ERU9DVFNGSDhhYWlKVkV1UjZX?=
 =?utf-8?B?bTdaRUp0ODNicVBicnNiZ1NybUhaci8rd0JISjFrSVdrUXZFRzc2czZLT3Z2?=
 =?utf-8?B?cFdTczdoaGtFQ20ySW56WDljd0xjcjAzV3BXbUtFSWdPUnpWTzNZMG9SQmRO?=
 =?utf-8?B?L3JDKzBuWlJtbG9Eb3pCdHFHK3dsVHROekY3UFdiSTJnaGZSUGtoYXlBZjVF?=
 =?utf-8?B?aUtERUFtTVhjS3pDNnhOY1V3NDZqYUZVK09sNXl0UzRaa0REbGg1YVZ4TFRX?=
 =?utf-8?B?SnZlMmhnVURZM2VndWYrVTFiMGtnNjQ5TEVQamw4SDBLRUFpbmQ1VDlSZmdq?=
 =?utf-8?B?ek1iUWRHa0tFU2NOQ0l4Q0hGOC91VktTQmZZNVlTTkMxSCtBdlF4MTJwWHI2?=
 =?utf-8?B?NjBZVlpCQWU4QlZtM3pjdGYza3NSSUdNbm12eDhXQmxPb0JhakZZZzgzdXZH?=
 =?utf-8?B?TGlkY21mamhsTTJnbGtFN1o3ajlpQnlXelRWYVZhQ0dyOGdzcFZ5WGx5cUFl?=
 =?utf-8?B?TExqQVR4ZnNwcTVPODZRbEIwa3VXRWV3MDIvQ2dWWVpMUHlJaytnTXlYd25J?=
 =?utf-8?B?cy81N0tES2RmL0JUSFJnSThNdzR1d1dkNFNBVm5CWjZTQ3pJSG1YdFptS2Yr?=
 =?utf-8?B?a3ZFUHBUbDh2TVdOT29xcFdoYXl3SGlUZVlObHMwdG8wN2txRWVlZjUxRU52?=
 =?utf-8?Q?3psOtU4rvczJSYAiBzMh2urKP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s8mIVqf3mAmMaFotRj9UbLPqx3od7ydpQmAQM1QCjTQTr8ZjVYSUkriytkqnCyhKJgknMy6KCQkXHAnXugvXhKq99Jz3tro8LFqR7y6Ny37Rfr/tSMsgTajt3QlcwE7oRe7eAAXdTjrIQAv/tmgkK/Y67uMRgyGJcYV9Yp0zJ+odSXtz/Ky6j1bprE32osy6YsYWqiGuinRl5Lvhll4wX24jtnalwfnW19ONzOsdQ207SbOgQKA/6E5O4L+dxkmGs54lRI4175ZfzjigskXh1gXgoQwTIisqSHYFWh2ci0l2ne5MskOe6SS6xfbta9rImIy94kA1n/V8hhAEEJmEDl4tJ/KGXx5OuJfHNvhHBevPNUAdDD9S6CQnJ92SwAqxLiK38BY2aFvRvZx1/nOzB7LfWZ8+oVANphujj5Xa3WXnozt1FkSNEhU18AsdZdi8nEppost4TOZ1BLeapkOwjHmiCpTDA2AFBlkQVNCsc8XmWTLt3FxkwrPPPKHxVcX5cJE15KLEHsfXxit8uzcrPioYHn237yw1kw6buBp7Yr7nOVD+xnKiX1auOy2CC5i0dAPYUD+JwhaeNpZm/zxtZN98exYNGzsK2NRewoFW+7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2199e59a-74b8-4685-553f-08de2137c05c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 15:34:06.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5b88fMv1qiJ1VDMb/RTr9NYCDC2rV6KvIWO4WnuBv3HFhbAn9ON8sG5O5oGXA8mL0nd1YM4HxCsPSk9NtXt6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=988 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110126
X-Authority-Analysis: v=2.4 cv=K4Iv3iWI c=1 sm=1 tr=0 ts=69135776 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PyIonhzCJvRfZulA9-kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5OSBTYWx0ZWRfX2lxb6iViNOzs
 h2iCeg0hd0CoxZMgDVEpNyBf98yGHPy8anBsEP3tqnKQkNsNq2cVba45bugsyMeJlazFKRthbxB
 KF9qD6/qDoIKAO3biSgB5x+PPALfDTUtkv+uTIrunhsiAw9VJZZeKDK+TPXaGjBD0oUeLU8iXZt
 5VY+U1tpcQOlE9pY9ltajzj9KC0oLIj6uvoQLlr6XjphmlDQSbnUbNOXxIMVgPY99PIt2m5pgUe
 NBh/Go9cA2MuGo5Fw7lqxf4BvfgoO4v/QxY9EQ7fj8PZmVlzUgmKOrqHhyUAFU5cYoathu4BwSH
 Q+PJbmT0OmgTP9Ek5JKK1+1DdkP6TXZAIswE53QlT2LSwQFxcpctZhnU4ImjtKGDsf1wlJRvTfP
 5ONEIxtwdfkLRE6pLrGcP7WfOP0Zng==
X-Proofpoint-ORIG-GUID: 7yBitJaIJtLPFjgpnBjw0jc4fwHVCI4s
X-Proofpoint-GUID: 7yBitJaIJtLPFjgpnBjw0jc4fwHVCI4s

On 11/11/25 10:24 AM, Dai Ngo wrote:
>>
>> Last thought (for now): I think Neil has some work for dynamic knfsd
>> thread
>> count.. or Jeff?  (I am having trouble finding it) Would that work around
>> this problem?
> 
> This would help, and I prefer this route rather than rework __break_lease
> to return EAGAIN/jukebox while the server recalling the layout.

Jeff is looking at continuing Neil's work in this area.

Adding more threads, IMHO, is not a good long term solution for this
particular issue. There's no guarantee that the server won't get stuck
no matter how many threads are created, and practically speaking, there
are only so many threads that can be created before the server goes
belly up. Or put another way, there's no way to formally prove that the
server will always be able to make forward progress with this solution.

We want NFSD to have a generic mechanism for deferring work so that an
nfsd thread never waits more than a few dozen milliseconds for anything.
This is the tactic NFSD uses for delegation recalls, for example.


-- 
Chuck Lever

