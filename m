Return-Path: <linux-fsdevel+bounces-8355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59402833500
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 15:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBA51F223AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C814FC18;
	Sat, 20 Jan 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CgNRjn7A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nbs/jToO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0CFBEB;
	Sat, 20 Jan 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705759904; cv=fail; b=Mw+zb3Wgz6QDUQWFsDxRcHPCh+qtJxkvRJTpU6PYJI9XkklSPbQSCOX0URYYjZ1HHqqM+1ALnyi5Ad9dmlV54ReVlQUWpwj6w9ZTfXV2YRHyDx7hEyShqgSW17Q1vaFrV30ojqcJYyvhyJre5sxTQmnu7yzA6PRzqLZsmTfdQjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705759904; c=relaxed/simple;
	bh=47hxuZPcAc3BdnwrWCMTJ5PCK5Gtg7DpiWO3PlVKuB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NBz7oM+00CtM1WFGmmuEzgmS0TYTgh8Itehc3AsN+iYGo43Eih50osVFtzYl1PYSsklH6lS9cDR6npyql+gkmhXyvy+ZhOpXMZMzHJhGVNt3xaaRQOwCJfbEmx+jq+TTriKjBiqE1IbO8Bxrmw70/EmQnvwNP4RPB6IAsHTF15I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CgNRjn7A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nbs/jToO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40K4i8oq006342;
	Sat, 20 Jan 2024 14:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=47hxuZPcAc3BdnwrWCMTJ5PCK5Gtg7DpiWO3PlVKuB4=;
 b=CgNRjn7AAWdyftDwwcjd6fSoKEK+52Tr5MbM5UiorrNDKgFC3rwyT5cEsiJMBxBywKxD
 Zv8ZrW+wDQN+tKZNb3QRbKwSbF6xFnq3o8o1UIEpv+/rPjGznrQNKGThVgoYvEJiPIaC
 Q9bTpG5hPKl4lQ9QmYABYdKun6O7DrU0HInm5Rub+es9asDKC/s2mWQD40eRZBk7GNao
 dsVyZHf0kW0XYVL32tTodchTUUZf8M7UM8r7oeZgQPaiKc2T8bnNIc9QczG1M1f8vmch
 fCvuXVki3rqOY+PmYC6bjbGOgrI0urjyDirl1NH4s31rMP2IOynE1VCO9Uls2Awpwd4b OQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cugm2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jan 2024 14:11:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40KBAcG5029404;
	Sat, 20 Jan 2024 14:11:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vr4m3ygw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jan 2024 14:11:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyVloMwR1QTxzJWsOGPC6hR3fTipMGOJ94FNKM+UBkCbNtW9A0Q4mEwevZJGyO7J7bozCCtje1kmFn7m5vsWrg6w5RDSGaV+JkhPrTHzBcjA/sik+KyL44MUzXNwOlB5ZjRRPC6lG3fzkdxF2LcEdVto9L6phiBAwQPa9CthZNKk36+LjO3pAbVX3MVQx9HUJ5hYW4upZ9fOxsCE4mkObkUjyOQI2BChrzgXf/x3CFBtXXHP0HxJc7lOb59xgCBiMTYEa4YcC96DQFSAwcx291iEcAcnBWHsQjElo5YNS0hdze749Ga2i6R2uHt8egqzrVQ160VoZKFwnMHaRFK9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47hxuZPcAc3BdnwrWCMTJ5PCK5Gtg7DpiWO3PlVKuB4=;
 b=BxvOGciapzEfjMV2zjla9ikos9MNjcffft8f/baIcocBhuBOcigp0C7KePxsxEyds0lmcjQH8fXOBs8SyVR2gqHga6/ED8Vo9MJTzTn/lSGoShAojuMra93t1svN0BLYou1hJZ7vBccnu4Lb//+lrDeVqLiava72noOTykAfevJ/q/xHz5fixQODuuSqHg6SoD/LLF9JUZY1sjMNKj7e92ZoIxbkA47mC+oXruA0bWjsx4IvdaUN1Xty63hkxO8FfY8c2Yq7oCU1AXKMIDTg+EKFDlEfMg+NZaXWsUYa9ncOGh6AJsXlOmEY2SKKeb4TZm1Am8JG4d4HwbzHXDeUkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47hxuZPcAc3BdnwrWCMTJ5PCK5Gtg7DpiWO3PlVKuB4=;
 b=Nbs/jToOWnJQr4HB3K4Q2CAiXa7FoAsvCEAYQvAQNt+9ys44+ltca+i1ZpmvOC9EJ70q1f8TBPUAYkw07Xli5kao9FY9LUz7ocd1jDdFsDgsGki9scViZygJQapXjrnC8bYz+rv1AzVLmZ/gIVImChXxDwb+mbc1ib9RpEVVeU8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Sat, 20 Jan
 2024 14:11:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4fce:4653:ef69:1b01]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4fce:4653:ef69:1b01%3]) with mapi id 15.20.7202.026; Sat, 20 Jan 2024
 14:11:02 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
Thread-Topic: [LSF/MM/BPF TOPIC] State Of The Page
Thread-Index: AQHaSvQIP2UjINvWrUa0PBc2sS7Wg7DivwsA
Date: Sat, 20 Jan 2024 14:11:02 +0000
Message-ID: <B9605EFB-4AB5-43E2-8538-850B758F37B9@oracle.com>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
In-Reply-To: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB5866:EE_
x-ms-office365-filtering-correlation-id: 8d464c6e-e075-45e2-f770-08dc19c1a2aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 yGhv9SgCxuZJlxG7WxOSgqNcDa8IsFr/CeeArgHDR42y0FtwAylGgyXtRtp1yVRVKSB7/sTIfgufdaZ5Cx2D5NTfe2+eyT3xl4TilQfUz2pw50kE8l0BoJtu7tLhN6U4FZVxzUcryDKHt1rRu41yqeH3X2itWL+7vF99SEKb0NEjAGCRKiFRlB/xGP+a+Q0HSRFEXvYESpU8ylsZvbFT7wYj/H09iGtfaPwdnrtOZx0+u+G0QW1IaZHxi5vB0TM3m+xGa9ZTExEtWiCqkfFHCYUxS37DGEmoQBWN1xt0V6UKXGaMUrUYWc53QgKD8H52y1mId7TbXtPVw2CMuyxtev6txKX9JMlMN0SY3F59eRpl4Nf53o0ZLFgtS+euh7nmYxdnk9f2rpxnfLYyt3w+SsV0UVIOYg2vmZei0kySkzgKRLMsdrZtbIXhg3Pasyii2wcVG20MxqMpZ/eGi0nsbnuwRhn5tSGJZOLt0jFFT5SnK4MWFPRREX92OZdfzlvCyt5PNjwtE1h1rbdAx1NILAVhEmHPvh8xNiFcVNJQWHK9KFvmeWNgDmE161AmBWAts+W/HgkGLwT2mnUhI3+y0AhuNSwInIi07Q+CR7fSeoXdXsFlpLom0gOfT4+uSeuVtX2sCcVX1+HJrvdjVpMtAA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(26005)(2616005)(71200400001)(122000001)(53546011)(8936002)(8676002)(4326008)(5660300002)(478600001)(41300700001)(2906002)(6486002)(6506007)(6512007)(54906003)(316002)(76116006)(66446008)(66556008)(64756008)(66476007)(66946007)(6916009)(91956017)(33656002)(36756003)(86362001)(38070700009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?OWkzZG5GcVc4M2lFOHNTbGpwVWlSTGxJSTE0U2F6N1FoVkRSSkMwdXRIK3FL?=
 =?utf-8?B?bklSUUtmSUJ3cndWU1dhamhmVVFIQ0ZXTC81d25iY29UNHpvMEVxZHk5VFFK?=
 =?utf-8?B?SnZUQXlzUjVncnRZd3V6cFZUUnRPUGZ1MWJJZGt0NnhtK0hvaUR0YjQyc0tu?=
 =?utf-8?B?TE9kdU9hbmpvdWV4eCtjMHNXU2ZTSWRZNVhOMVIzK0pOS1ZUS3NVK3Z4WXJ1?=
 =?utf-8?B?bFJzNEFROWZYS3FZZUc5czZPc0ZOUk05SjA5RG1BbzJpR3I4SHgwUDZaZFJ2?=
 =?utf-8?B?SEUyTXVWYm1aTkVjbE9lNWYyMTg3U1RhVHh4bS9Ndkh0Y1ljTFR5UFRmc0tR?=
 =?utf-8?B?U2F0OW1jNWFuTm9jYW8xWDRiTHRvY1Y5SU0zVzVrcE90SWJ2bkFoNTI4MjZL?=
 =?utf-8?B?SVJJTElEQkE2VmhBaHpQQkFzM2FJSmJyRXdGRWdCbmNobDN2Zy9Ma0pqeU02?=
 =?utf-8?B?RlJjR1dBYlZic3cxMENvbmlkcTZiU00vVW9zTTI4Z1JiRVVUVHVPbVRIQ1BP?=
 =?utf-8?B?czVYV0MrRWJMK05Kb1dtakZhK0tUdEFHclZJWDRER1FSOTdvQlBTVXRwbXFC?=
 =?utf-8?B?QVZHRk4wbXExeDJIbURGTkdqMFUyb08wMmVlR1FLT0JxL3RhcHpjd3gzT01U?=
 =?utf-8?B?blcvQzFRTUFtalVFSm1XYVVraUh3elRPYUlrcmlOYUtoMWl3ZUdHVzloZnpT?=
 =?utf-8?B?YS9tdEs1eWxDV0M3cjR4UXBTS3BXMXdoTFdLdjN1YUIzUnlJUmcxVnAwaC9k?=
 =?utf-8?B?Y1Jtd1FvWDNHbUhqYWR0QnZlRE5WaGh1cCt5bTVreE16MUZFaGppWWxWeEg4?=
 =?utf-8?B?b041MmZoa3ovTHBtYzFFMngyTGVIbyszV1Zyd2FiLzQwOU9GdnZNQzRHQm5v?=
 =?utf-8?B?VlBaUlBPRVV0dzI1ZmNtR0lCV0pnTjkxcVprakNyUzRqK1lWTnFIZks0c2Uz?=
 =?utf-8?B?eWNDeWRKYmlWRkU3YSs1UzRjQUg1S21qZTVjUTk3aTdIcDZjNmJScEozbFlt?=
 =?utf-8?B?eVJWQ3UwYTVRcWpBaExadUJTcEZCYjZ0MDJ1L3dRUlROMEJucHY4UWJJdDBl?=
 =?utf-8?B?eHB0WGVlRlZKcTZsNWVMTmdUYVNlUFVIRnFPT0RNZUdxTkVzazQ3ODBaRGli?=
 =?utf-8?B?M1V2SFh5ZXMvNFRQZC9tS2RwS2s4R3UzY3gwUmpYVGFwdERiNzlPcHV0ajB2?=
 =?utf-8?B?V2ZNaXhZeU1XRUl5SGxCRzZZcUFuMnNpakprbG1TNmdCT2xqWFo0dHhscm5k?=
 =?utf-8?B?cFNCcmhTZ3FqUHk5L0JEbUlYVVJoYmpySnRucG12akdLSFZjRU9wVk5nK0xZ?=
 =?utf-8?B?R1VORU10U25qQ3Vtcjd0UXFYZndwdDlNY3V0Ny9jM21yd2pqRzQzWFBLejJx?=
 =?utf-8?B?RnJNenVwajlUd29senNNTkdKaGlpWjA3WUVQTmdIdUZGUm1pKzR0OTk2VWlm?=
 =?utf-8?B?TWxLMDFUV2F0YnJDRjBoR3BiVHJnZUdoQjJ4Mk03eDU5c3htRFB4MmVIdGxO?=
 =?utf-8?B?Z2krbnNic2I2amZCaWFMZEdBVFVXVy82Z0lNODBzQlVjWWZDMjhXNHNNaEg1?=
 =?utf-8?B?Y1hscUNIOFIyaFJRbTU5QTZhZ0ZXRCtmNTR1dEd3WkJXWDBOeEFHU01zR3li?=
 =?utf-8?B?THUzTXQ2L1lJUjNFbHlzZ3lSNGFtc3FmV1d3dk5zZDVxaUZLYWV0WXNIdFZ0?=
 =?utf-8?B?S3BieTdJWXlzRFczY2VRRnZyZXlrZFlhYzVtWjRzVTRwU1gvMFFEZzA4N2Ux?=
 =?utf-8?B?Z1l5MDM4byt0b2ZHTy9sbDFiQWhWSlF4U0tEMklkNW4wT1ZlYXFHVjNhVEhJ?=
 =?utf-8?B?S1F4SHdEUHY4M1drZmpsRTlZa2lBNWFtVnV5NGdTaWZZQnAzeWh0VnFhUGZn?=
 =?utf-8?B?K1VUdkRsblI1eXAwMXdIU2luRmFPaTVkSG95a0JLNDY1MURucmduSFJUbVhS?=
 =?utf-8?B?VExzQU1OU0RETlZNZCtFK0t0L3EyQUQ0UmRiWDlWeWhnQlRrUy9JVFU1THBI?=
 =?utf-8?B?clFONFlZanZ3eUdPYUJyblBZQ2xrcnEraFY3eXQ4WVBSMUg0RkNUVENUQVRK?=
 =?utf-8?B?eTNJU1JWK0xyaXUvYUthY1ROMDVYMGFTQzcvYVBva2JleUZrR042K2V2SWhu?=
 =?utf-8?B?R0VTTFgxTzQ1QVVaOTJjeUxyTEhNaTd1TUR2cXNsNXp2ekppS0ZXaFo1a2dp?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40A408B3CE2ABF41A7FF90C771DA0626@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tUI6uLcCFUEdQTBvls/Sl3qNAa8ilFL9rimopwEHJ3/8WExPm2TDUXIxrUDrD4aXvS3vrIXeuH0ga7XPC9vdPt18dlXkk79ymdYue5hQykga4KdCnFSftP1gqQpsOtieBP6esUBZjQQ0MXjgZFQ7GrXcQohEuqT16HnqaetnkYEuVBzKEUuZr7b3DCfr8gNoOneU+DERcjHEADV8GTKAkan3mq6WpteNbY3GK8ohcZCX4yZRoWCPtWPt4LYxPWJ3MSCSevLGujXriARD9EfyriV23z851GhicwxBnbErX8Y3WYnCVH/IpXba1a5Lfjmev1a6YdZjkWEqT0K5SDVaEP2AWzRzaAGcnnMsvPDWDdsiNS8BFAAPSTrUkM30ySJdj7Ebn8osf22W8FZYIZhQ9zWNiZWLqYkco2oL8n8GWkIZI+LoKxA+iJg2CFdIyr8OOhFc5GiDsr28mVgmZfawGLYrW+AtG+6W7ADLvK/g0kebJtTTrtBHqlNCiJ/7eagBGbb1LCn+RYAN4s9iAuOly/GUfUiFFja5fh/lAwaIC4m7T1Kc0zicD1Z+KWE3YpfpKNhbHuPaLy214FhT0n/w2h5QPQj0S6IGxswjavvhhQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d464c6e-e075-45e2-f770-08dc19c1a2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2024 14:11:02.7764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N8au0phqC+dB7ber4NjBzePwOBYzUzXBqeDZR9W6HmJWezSWnn1zatUkoQETvlbBVfm7+KZxZJ6P3F9nKaGRcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-20_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401200117
X-Proofpoint-ORIG-GUID: EyQ7Zxit6tQ4abc6M97rinjLLtLDlN7K
X-Proofpoint-GUID: EyQ7Zxit6tQ4abc6M97rinjLLtLDlN7K

DQoNCj4gT24gSmFuIDE5LCAyMDI0LCBhdCAxMToyNOKAr0FNLCBNYXR0aGV3IFdpbGNveCA8d2ls
bHlAaW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBJdCdzIHByb2JhYmx5IHdvcnRoIGRvaW5n
IGFub3RoZXIgcm91bmR1cCBvZiB3aGVyZSB3ZSBhcmUgb24gb3VyIGpvdXJuZXkNCj4gdG8gc2Vw
YXJhdGluZyBmb2xpb3MsIHNsYWJzLCBwYWdlcywgZXRjLiAgU29tZXRoaW5nIHN1aXRhYmxlIGZv
ciBwZW9wbGUNCj4gd2hvIGFyZW4ndCBNTSBleHBlcnRzLCBhbmQgZG9uJ3QgY2FyZSBhYm91dCB0
aGUgZGV0YWlscyBvZiBob3cgcGFnZQ0KPiBhbGxvY2F0aW9uIHdvcmtzLiAgSSBjYW4gdGFsayBm
b3IgaG91cnMgYWJvdXQgd2hhdGV2ZXIgcGVvcGxlIHdhbnQgdG8NCj4gaGVhciBhYm91dCBidXQg
c29tZSBpZGVhcyBmcm9tIG1lOg0KPiANCj4gLSBPdmVydmlldyBvZiBob3cgdGhlIGNvbnZlcnNp
b24gaXMgZ29pbmcNCj4gLSBDb252ZW5pZW5jZSBmdW5jdGlvbnMgZm9yIGZpbGVzeXN0ZW0gd3Jp
dGVycw0KPiAtIFdoYXQncyBuZXh0Pw0KPiAtIFdoYXQncyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVu
ICZmb2xpby0+cGFnZSBhbmQgcGFnZV9mb2xpbyhmb2xpbywgMCk/DQo+IC0gV2hhdCBhcmUgd2Ug
Z29pbmcgdG8gZG8gYWJvdXQgYmlvX3ZlY3M/DQoNClRoYW5rcyBmb3Igc3VnZ2VzdGluZyBiaW9f
dmVjcywgb25lIG9mIG15IGN1cnJlbnQgZmF2b3JpdGUgdG9waWNzLg0KDQpJJ20gc3RpbGwgaW50
ZXJlc3RlZCBpbiBhbnkgd29yayBnb2luZyBvbiBmb3IgYSBiaW9fdmVjLWVuYWJsZWQNCkFQSSB0
byB0aGUga2VybmVsJ3MgSU9NTVUgaW5mcmFzdHJ1Y3R1cmUsIHdoaWNoIEkndmUgaGVhcmQgTGVv
biBSLg0KaXMgd29ya2luZyBvbi4NCg0KDQo+IC0gSG93IGRvZXMgYWxsIG9mIHRoaXMgd29yayB3
aXRoIGttYXAoKT8NCj4gDQo+IEknbSBzdXJlIHBlb3BsZSB3b3VsZCBsaWtlIHRvIHN1Z2dlc3Qg
b3RoZXIgcXVlc3Rpb25zIHRoZXkgaGF2ZSB0aGF0DQo+IGFyZW4ndCBhZGVxdWF0ZWx5IGFuc3dl
cmVkIGFscmVhZHkgYW5kIG1pZ2h0IGJlIG9mIGludGVyZXN0IHRvIGEgd2lkZXINCj4gYXVkaWVu
Y2UuDQo+IA0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

