Return-Path: <linux-fsdevel+bounces-11549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951E85494C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 13:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EB628E313
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 12:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C929F52F75;
	Wed, 14 Feb 2024 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XucFsLRm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OVssf88b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE9D52F61;
	Wed, 14 Feb 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914226; cv=fail; b=o4v9U5WTr+5tNUkxMj0NgKw4HlqXw52SXcjPErgZKqvO7OCdNB59MHaVeLDOQhORI6xj3toZstwqf+cDSduZJ69d9q/yhEC+9Xqbvh7EyWuAQYDYTGBnVe9rIoa4ioVDG0/dSPsDbf7j5+7K/+2kdPURVEKGH1brG3uJi3KyGSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914226; c=relaxed/simple;
	bh=m143JsOi2+/AC1lFMRDHyHgYSOWrZz581ht4BpyI254=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jE/AD3vsQNHVuQcMeJNkKzkjfllXFIqYve3pndXasRq7ffPtgEzug2IT6hzHYdnOsi86spH08VeW8+aptTX114kBQGtEviO99XAR1wor9VM+fEGgLGfKnNaMdvCPJNvgQOQDrbogthJ7lVabtv/DP11GoSZPrl/qQ5vqXN4LjnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XucFsLRm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OVssf88b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ECJJCC001075;
	Wed, 14 Feb 2024 12:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=j8QL9SYwn5jHRjd/uCgYKaDOGxWrc6sRcG5PaaNUddY=;
 b=XucFsLRm5D55J4yVvTxi938u4gLf1bbD6iW87GWgeUWuwm1GyQdbGxX7H1tZf0gWXNnZ
 hRVUWrNmOFn0Y8sG3/wIbIjD6upHM7YN9GUVcQ7gkS99e3Yqag5Mx0TPDKMdc//fXFop
 z7is/RsUxl/R92YSUXJR41ks6AF+xTI8Fi1L4wOK61Ixl95VZOgBm5hT584QfpUwuXJl
 RquhuhIQrZ2y7lmRoQPr2RaZTIJ9/sZr4RllIP5UwH8vD9SkM3p3Z/ufr2mzAKpJWKdH
 gm7ajpyJrAy7hxI5pOqAScDiAJMy0Avc0B/jKEOswYLtQJRUcav3tJWJqcyNbFBcchok 8g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8wdu80q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 12:36:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EAjJiA015009;
	Wed, 14 Feb 2024 12:36:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk8vmmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 12:36:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9HK0hb0IBhJvyClYeruAAnoYN9gCiaNhvXbEnnjeg0W+xtKA8N8cOxB4Q2Pb6BgBPT0KzhRqyVyzJJzLAQkwSFriu4LKR3rv5r1tc99dqJvHam2a99ovxnBm6o6F3mvOkkHmSc1Ri7jIBIOh+Nmzx+ZJrZiF5ojq+MPLlF1JKCeBfkysUNoVxmEwh46wG3H/6PfjgbRRKQOMsj6UPL0LYx9vFIxv69E8gG6FUtfrOnNsmLtNX+8iAJciuQt0StQUSzUjbsit+LFFQ+EcxlZWL2VxwvRn8Q1fWy+3bjkOv8Tfu+CD/olzenyiWWZMQgRHW0J1vRBTRPOgCFeajvhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8QL9SYwn5jHRjd/uCgYKaDOGxWrc6sRcG5PaaNUddY=;
 b=mFq8bjpTNDA3G+3FWuAfon5l4BcIJqSugXImCjebN6K4jALk8TrwXbOx8JG5eulms7l6V3LyqHv/kBp4IeyosofmK+jCBp4slXgqiCl6A0i1Fm0qu6JvGFnH/2cv1Df0mEtxAXXReyKARECO0j3VW9skD7MLhi7Hkd2X2j9lBubkF8C9NIhJMuLjaSF29el7wJXq6CnV4W+HHFUtm3rKj8wVyb13AQp1WRJTYhtl4S189SR4QZPudFgF93B8AwwRVaEUaPOZIgQ/Ft57JVpr+2g2IotrRtFlXEo1Uc99j6gDeLyAIHZpJPeg4Qd+ilyBqCwsGBOdH5M/uAG1NXviUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8QL9SYwn5jHRjd/uCgYKaDOGxWrc6sRcG5PaaNUddY=;
 b=OVssf88bR6igQ7gzUA9xjSh91jfdgvLAu8qssO3LxLJuIZHkdwT0uEMmCX2zgmDuhfZOM1ptHtSvo+PRfkYPuIo/vXTggTL0n6qtd5mPeZH+S/1n74Ciw6xjHDhwvoYU3jZCLZUT67uhVbmcD3IEQYUlOWTsHWoAsQrwvOT2t+Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 12:36:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 12:36:45 +0000
Message-ID: <b902bee1-fcfd-4542-8a4e-c6b9861828c9@oracle.com>
Date: Wed, 14 Feb 2024 12:36:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] fs: xfs: Set FMODE_CAN_ATOMIC_WRITE for
 FS_XFLAG_ATOMICWRITES set
Content-Language: en-US
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-7-john.g.garry@oracle.com>
 <20240202180619.GK6184@frogsfrogsfrogs>
 <7e3b9556-f083-4c14-a48f-46242d1c744b@oracle.com>
 <20240213175954.GV616564@frogsfrogsfrogs>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213175954.GV616564@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 74191a34-d356-4e08-0f50-08dc2d599ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9hUNlAigHV0wP+ob804iLfk4uB1c2FDKxFxn05kC9UdVKdtkE/aQ91TVVLm1+4b0WOPEK00qDpmj+aAImtcxrWyjyioKLtXj0q1ASI4YVCSS4evsCqIvgBm8kuAsgqCZksCKN56WhTj12a9Y1gmuoUgintdShMCG1at1Yw5zLMS8S88HluZtK5nSg1IzSGXyYjR/dxuome/GovBpNZTEdtcjFc5cyRdD/mfoUrYzlUJFWjBfU4YaU8paTFNpZF2TmYMo1qlnGUNBxmIwd1EAnay3yGNoGZn7UubY0Hv9YYxXEqUNeexs2JrCN+0YpsP7tx9qorvBCsIaygXDNbOk0lzEgoqT28WrtcQFNIW30TRbckoDjMo2iQc1qLkUWx5wujlyYbdVqwboN/oQjW+OEIeF2vdgwjRT+w0FSJ9PLzz7bkdBsH3qQHTqZRmrXgrrYgLdn/XJFnHrQ1BXyf2xbSxfGo7n+u1i2DPvrYtPzYk/ZrItYNUob3Omqyt3VZ3l1I5VTpjm13LUFn4eaYLVrJt2ES/moV1RukGfz0bYnwuAwQMVYIYKFVDqtM68stbn
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31696002)(83380400001)(86362001)(38100700002)(6486002)(316002)(6666004)(478600001)(66946007)(2616005)(36916002)(6916009)(6512007)(66476007)(26005)(36756003)(6506007)(53546011)(8676002)(8936002)(41300700001)(31686004)(66556008)(7416002)(4326008)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dElhNUxUOW9DTFNTMno5QkFRSEFXOTRQSEFKNm5KZEdnd3AzbHkwUzdMdTVC?=
 =?utf-8?B?eWtiQ0VNUEJwRURpTVhzblZvdVhZU3B2WGVYMVVKYy9wVzM4NmtFeERrSUtM?=
 =?utf-8?B?cFRiajVzVVczTXdBL3hGOWpvQUtWTXpzcnVvU0dxYUhqeWM1elNIY2xIUEkz?=
 =?utf-8?B?OXJISDQyQWg5UHp2cWtiam5OTVdIYzYyb3hyL2s5SklrdmZUL3MweUZZVnU5?=
 =?utf-8?B?V1JMaDBCYVFTc2R0K3NIUmczaFhublhPMVNqbEZvQTRVNVJrMU05NXVPQjRl?=
 =?utf-8?B?K2pQSHdoUFE1bFJ5ZHlmK0wrNHRuN2JOYVhScko2YUtDbzVrOUlmUElUa1Jw?=
 =?utf-8?B?QmluUldJeVczOWRYYVEyS1cvTnJiVFFTOXI3a1REUnU5b2xtdk02clNka3g5?=
 =?utf-8?B?Ymh6T0JZdFUyQjNVbnlQL2pabCtBaE44aFhNNXFMZ1dOU0xoT2pPdUE3WGZD?=
 =?utf-8?B?MExqSUxPR3Y0T3J2UzY4ZGFqa0hZUE9hVytkbk8zMXlESEtTaVNqK2hKS1Rn?=
 =?utf-8?B?RUtCUERrL2hmRlJHSEZzOVZTZTE3TE1oSEtjQ1BlZXlRWURQbXIrVkxtVXFj?=
 =?utf-8?B?Rkd5dGpWV3I2cXNPY1k4MEZHQzZNdVZBUXNNK2MxQkl3ZjZmV09wNTFrVDVq?=
 =?utf-8?B?N0xDMnhWYVY0WndjNWdLSXg5ZDBGaVBUMThuM2cySklpWTQ3d1c4aFFvUHY0?=
 =?utf-8?B?bi93c29sbktUdXpjdXlsYVlMRDhjTlFLd05RLy9kRTduTUtnU2VLcjJnNXhF?=
 =?utf-8?B?MldIa3RNZ003clNtV1llN3RleENUdFp6MGZWaTE4cGphTFBDbTA0Q2V5NkFu?=
 =?utf-8?B?V3EwcE5EdVhqdUg5clZSbnZ4NWdtcGpwbC9UUVpjYlA3YTY0V2FPWVhoRjRN?=
 =?utf-8?B?ZG5pM0JPTFgzUjVCN0pXVTBtZE1YeTdUTXNqWHA4bVBzbU1uV09jZ2E1c2c3?=
 =?utf-8?B?bHViNHNUQ2ttRE1tNURXalJKWjhPblY1aWRZeHJhck5hK1AyWjlBeTZOUEdh?=
 =?utf-8?B?S2U5SGphOW1hRTM4OHFRL0FVa2VZYlFRUkx1WkZVazlmRUJFSEE2UFZScHJ4?=
 =?utf-8?B?ZnVuVy9IS2RBR3lsY1AwLzN1YVhNMWJ1OTFWaXllN1k2VmhmZjNvNFhSOXpE?=
 =?utf-8?B?WXVvYlNGMmFKTEF2MkhiWWVWNWMxbUVZY3FpSlVrc3plOG1hR0YvaTJYYno5?=
 =?utf-8?B?NUpseHRBanZmUXY5TVNqMS8xR29vL3dJQmd5QUNncW9uczJkS2RBcEFOSG0x?=
 =?utf-8?B?MXNSTFBhZDRNckJYUVNWREdFZG5vTmFJMDRnOFBhVmdBR0JGaURyaWhieE9r?=
 =?utf-8?B?Zlp6Z1VlanQxeXN2ZWkyeGtEZytzSkFXWGZyajVzN242YjZIVm03RW1IZzk5?=
 =?utf-8?B?M01yZWVxTndtTExCUStITVQrdDQwRFhTSUtMUmxDQWdiTy9FVlVPalM1aWl4?=
 =?utf-8?B?Z3ZKQ3lOb25SaVZOUmNqZXhGZzhTQ1kyQ0xXZm1hZ2lmUzFkOWx4U2JqNWdu?=
 =?utf-8?B?RXBHZm1KeEVsVW5pYjhFN3k4NFBnL2pZSm9xUWtiV0RuT3hrSzdtTjNicDk0?=
 =?utf-8?B?NDQybHVXZ2lKQnZScGREYm9ldmh1QXdSdmdDWWVHMjVlYkYxRXBrOHZVL0h0?=
 =?utf-8?B?Z3lGQnpOVGozalcrUU5WOUNEaEpNeCsySWl1R0FXNUg1dzN4aWZxcHVTYVhm?=
 =?utf-8?B?YWtCeUlGN0hZSEdrYmxhUnBOZnY2Wk9ITlZpMWVXZCtQanIrU2ZGWXI5U1Br?=
 =?utf-8?B?K3RsN0lmTFBVT0hRd0NrK1ZMdG9jWVlQOXc2ZmFiOGtMSGdnRlpQNjJVK2dD?=
 =?utf-8?B?b2ZCUnlCdHFLSWtBN0o2akRrSWZCNjh4SkpTR3dKOWJWbGpVRi9kWmlwNDlh?=
 =?utf-8?B?QVdBekl5WTNzOHVpMWxTWVFJVUxxWEdyLzNxVlBVd0NpZ0ZjS2pUSENEUSsw?=
 =?utf-8?B?OHZ3dFcrUGYrdTBXRTZVYkk0YTdZVVZ4cXRUT1RhL1JqK1dZRWZVcmdnV3Vq?=
 =?utf-8?B?TDE1TERLZUszOHdmdFJLdkdlVFhRZExvQVNSUCtJVkIxK21GbFcrTWpqRXB5?=
 =?utf-8?B?Z1RqWWJlU3p2K09LRzlYeWpNZ3NQOVdtaGNKVVp2NElWNDFLOFl5K0VmZlNX?=
 =?utf-8?B?c1orNGVBbTVZbEI3N2VJZGdsVlIzL1FseElTdkxtYWxTbkplYWI5T0R6RENy?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QBE6qpvdCuKe+FqjiR9X0G6LKtXV79KRA+tO0vzq70/Q0Fy7Qmhag4N04cmNrQJpFNlKT7UMkbN2h7cdWYSf8/Mn8pK88EgjIEhpuhIZnTcBv1SU0xkinvg8Q9C1YEcdgkg+O8qecE7QM0EYCcEDSiMsMstDXtnETy1uR2r8b3mwvvAUUoddS1sSt/pDJQ1E2cvBWrp3Vl/FSAlH1ApQ8r7zSWL8YVSuii3hShFBgt4/dc3IOzZgNBtywh+ZKfwKDSM9cABvL/euQHQEn2sFZklhylpkHcbikMBnN1/QvJ9Koq1G9x9I3R9+Rzx84+MqcLb2jvGIi2RM65uqxAXC+tCtifin8UNClFos9BxXsjdFu/gfRLBXxf/d+XDKM0nNsgYKDGOJpmttDPOgYIEfpR+Z1oxdT10MZ0wHThiCFDZ3eESzpHe4cwa4BKO4N0G94dKkKYmKDMtZGVrdCt9B9i5Le3I1hVDlxxOb8nsDBZc6z1vRTu5CFryB7sB9vcrprsRA5PBXe8EVzmeY/fXSK082VV52XDRv6mNqiyBTG37/PlYZwGkv6G2P0jv0UsUgHobz8pdd19lEBKsGtPgHfcyGrBY3LIgkBEpKmCnVBH0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74191a34-d356-4e08-0f50-08dc2d599ab3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 12:36:45.2330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQP2tv3Hdy9QjjYKJdfT1UNO8Fe5WBA2VpVGNRtVFwLW2f6usa8t8m3Dcpk2SzOo4x8JsjQZH4kI0qDksiPo2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_05,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140098
X-Proofpoint-GUID: vaxZKyLzgWWkXOPdkNF8oK2jAv_1J6yV
X-Proofpoint-ORIG-GUID: vaxZKyLzgWWkXOPdkNF8oK2jAv_1J6yV

On 13/02/2024 17:59, Darrick J. Wong wrote:
>>> Shouldn't we check that the device supports AWU at all before turning on
>>> the FMODE flag?
>> Can we easily get this sort of bdev info here?
>>
>> Currently if we do try to issue an atomic write and AWU for the bdev is
>> zero, then XFS iomap code will reject it.
> Hmm.  Well, if we move towards pushing all the hardware checks out of
> xfs/iomap and into whatever goes on underneath submit_bio then I guess
> we don't need to check device support here at all.

Yeah, I have been thinking about this. But I was still planning on 
putting a "bdev on atomic write" check here, as you mentioned.

But is this a proper method to access the bdev for an xfs inode:

STATIC bool
xfs_file_can_atomic_write(
struct xfs_inode *inode)
{
	struct xfs_buftarg *target = xfs_inode_buftarg(inode);
	struct block_device *bdev = target->bt_bdev;

	if (!xfs_inode_atomicwrites(inode))
		return false;

	return bdev_can_atomic_write(bdev);
}

I do notice the dax check in xfs_bmbt_to_iomap() when assigning 
iomap->bdev, which is creating some doubt?

Thanks,
John

