Return-Path: <linux-fsdevel+bounces-3209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E37F15DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E372825CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EE81CFB9;
	Mon, 20 Nov 2023 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1spc1QS5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EiLq+wmP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A262DCA
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 06:39:39 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKDn75C010319;
	Mon, 20 Nov 2023 14:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mjacMzl75eeJwlOBKcW4agfQlMizYwQYxtasPUvmIug=;
 b=1spc1QS5mVOq9iCDXsmPY+sAKjgDBhLcjZYLypVx2ZI/dgnwR3NJuzVMXFyRELoOIBFG
 WBOWJwhST0yiYgEvlP6ckATfgDSfRHAf9af65RjSWWm2lsolZY1+9fWXc49jZwS3nKZz
 kSdLRG5kqXw0UEG38AczZjZFX9HIsncsxwcC8pqCpkKZs3eqrD5HBvw7UyPfugPGMKQs
 /ctAylbJy6u75OTeSfJgPvROBCmLZNaZeofAea/hQ/Pw7pXbmCgYQhqAFqUXn2MH7hCO
 S+6Tdq8zY6A0G8J3YS2YvhcpimpNzSf3rllSutRtZAadJt1Jx6r6xKQxVlccFu3+4sjb WA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvuascj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Nov 2023 14:39:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKEV4v7040598;
	Mon, 20 Nov 2023 14:39:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq57tex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Nov 2023 14:39:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nl5JvLWqmJgjlA3AkkuhHS6Leo2L+gjsSCdja+0Ryc55quEAAEpeNw9Wx3ghu0HgwhoOcAcC/ILm/3D/qmh0TZ/Xi4SHNOZR4A8bEDH/GBaAh7DVqnBlwQYABku2RHprEYqWHRFexNYObvrUcWALHZi/rA7aOc4iIzHuXkrBVyd6mldi/i+tsScyE/uUv22lTbt2e4KR2UKkeRtPonATHs8RJvWs4kRmej/TqoGVjzO6Nbv8G7dhOsZBMVi3AUK0NGRF9W4j1W182VXLiXrWix/oePn9CNcwFc1hW5aoveyEbI2aD/lnjUIXRFMZrO6UqLHNj8dfXR0kDEbwKDaDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjacMzl75eeJwlOBKcW4agfQlMizYwQYxtasPUvmIug=;
 b=GRuIhe8RYcyYFEpmH/wYbiZAzw4RP26iQUAYt85qE9q+h4/OvkBX5eqqZENk2qb7y8DTZbhpHLSNfYJQi7qNMy+Q9FBvS0HyIIa+JfntzoMMceBdgYhgCCOqJLN777fxNEfaRg0E204JFgQLFZbPiTB3QudDswuFkwMr3UKxyMZaiKkw+WtD32fRim7i1fkhhjmSrB7VshrXyGV/jRDw0gqwPz1av+udUD8Xb7zACNn+C5KR7xHvDSYrmGzN0/hY6NAhXFTm48Q8iV1zoDqgjQ8j7/SWljYLcBXdMZfqQu+9uJ90D3VhOQ/hzDimP5Md9QsU6VhXAuir6yn5zx1EdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjacMzl75eeJwlOBKcW4agfQlMizYwQYxtasPUvmIug=;
 b=EiLq+wmPU+H9sj49ZGnGNnM1BAdUbFL5dNUwX8ShOtNju6qc2QRzN7msjGPFM0Zc/+Z5XF2T12b3l0mjHJIXcdYPsnkWUmtxwyvpb77GwaEnszNt5LAQrQevj1a7CvqGClqFU84oTS4W03kHNZXcxEJa2vS55xeIdo91cTxSDz4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7236.namprd10.prod.outlook.com (2603:10b6:610:12a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 14:39:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 14:39:22 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Christian Brauner <brauner@kernel.org>
CC: Chuck Lever <cel@kernel.org>, Tavian Barnes <tavianator@tavianator.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v4] libfs: getdents() should return 0 after reaching EOD
Thread-Topic: [PATCH v4] libfs: getdents() should return 0 after reaching EOD
Thread-Index: AQHaG0QCVh8tc7+C40yyPwkgS12GO7CDR5IAgAAAjIA=
Date: Mon, 20 Nov 2023 14:39:21 +0000
Message-ID: <AF3760DC-EF1A-49DC-BE24-6EEFDAA11E90@oracle.com>
References: 
 <170043792492.4628.15646203084646716134.stgit@bazille.1015granger.net>
 <20231120-lageplan-grinsen-25b44b4fac10@brauner>
In-Reply-To: <20231120-lageplan-grinsen-25b44b4fac10@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7236:EE_
x-ms-office365-filtering-correlation-id: 0e896587-7f4d-4fbd-9761-08dbe9d67c42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 X7qb2qA5VIxpzWoGvS+u4//ReDlCsGpbsjJ4xZPOmMwW5nr1WuXgNvR6FhY8G9dQcEPETBnlLaIjup6G6Onqt0DrazVlARquBP6ibpnKxcwU9kYgRIpmPSfDlTgfE+6O2IjoXFtCX19yP3DjHpbJYHDFrJQ1TzvUraLAt5V7lJe21xF4glB8w0vZszLCpV4RemK3XiiP8vMpJkBsZr2Y1JwTZLfuZup8oszOdBifI5be66TMRHnUCCUfSxPz3EIdIP9KxoOViD9AD7JJQhjdtHxakI53qzH/yqTOveea4fKH7gYkBRUV3ealyP8TsB/h22cQdGX/TBXQjywDnhQIlv3jzYS7baisW7t3HsR7/u2SMCuOECFDtZvu8QTyeAxMbJG6i9z5xIPTaPRhTyXx66wWmHMW6IswvcKHcteZjlUwgy5iOYov6PVD6cuNhkPjmR1t1ZvxQBWuH85IQRX6bJwN3zytHcWJWcL1AAtKYCle69XZfwp6Crpt75+JwFR7rXlrIWgFbcoEri8edEcvGKhjxZFYtpyxM5xVo1ziFxDV7aLmF2q4ft5fqE3+8d3EWXAAQqytR+xxWXEECTNzTBAzeVxasmmu6YGYLg5TeHtfejM1YKmCw5y3WJLrwM3ET/Qud+R1IMRspqc4dE61zNK60Ew5/Z8sL5qMagDHsonW5VATm0ZcYBwPZ0hyGpic
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(6512007)(53546011)(26005)(4326008)(8676002)(41300700001)(38100700002)(8936002)(2906002)(5660300002)(478600001)(6486002)(966005)(6506007)(71200400001)(91956017)(76116006)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(316002)(33656002)(36756003)(122000001)(86362001)(38070700009)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SGh6NVpDMVAvNjZFa1c1eGdtUWRiVTlKbVBsYTE5VWtDcUZXcDFXZWlaMkt3?=
 =?utf-8?B?djVDd3NVaHQ1Zll1ck5OTkRTd2lYbmRuVmlzVzlHK0lOVjFKSjVwZlB5UFo0?=
 =?utf-8?B?L0ZjRytYaEwxRnN1UC9nUml5bm1nV2NWNTdLQ0x3NHRKOHdxWUNlSEpFRFJC?=
 =?utf-8?B?QmdJSnduLzhmalZ3dDl4V3cxRlh2Q0tuckZhdEVZWFgyQS9JcVNFSVZJU1lH?=
 =?utf-8?B?VllNWnFlcTAvdGFRWXBPU2YzYXZXU3R3RUFteVJ2dFNJT0lvTzBod0VjaDRu?=
 =?utf-8?B?anBkaFovbWo5Qm5ZMVFPeXdML0RTUHB4eTBFc2srdG0yTy94MXVEbjdFclJt?=
 =?utf-8?B?Zjlnekd4OUllWlA5dHk5d0wxd2ZuUTBOMkF6Q21lQ0crczR2dk5ia2pYOHdK?=
 =?utf-8?B?ZGtZRmgzT2xiS1BTWi9sb0pyNHdteCswdW9OdUUvbG0xQmhwZHZEZ052a0tZ?=
 =?utf-8?B?ZXJ3TWtoMFZEZmVmTS9hT0J6UDRaY0tDTGo0ajBHVkFNMDJUUy8wRWo2L3Bm?=
 =?utf-8?B?bUEwOCt2V1oxWVF6OXRualpLUTc4V0JrZGV2WmdKTFpjYnJudEFRVzZydDh2?=
 =?utf-8?B?RGRsZWkyMThNWkZ0OVp6UXpNZFJhKzcwTWlqZUkzY3Jvc3VmeEd4Q2R2Q1hS?=
 =?utf-8?B?aDE5ak9Bcmc3dHRydng0K2cwa3Fna1dBQ012OG50dnRnaURwR2FkWEo1WG00?=
 =?utf-8?B?RUVkdTR0NDU5U0N4ZjF4SkJJeWE0QVFDRDYzMUFXU2VqY3kyVVFEWkRhMHE3?=
 =?utf-8?B?eFo5dmVtVEJnN2xRL2ZXMGo2dXozRXlkVXZlSkFtTUdvOHVZL2RIMXN4cERp?=
 =?utf-8?B?ckNVSDViVkJpWEJHdXlTdC8xcWxHd24rRkJieFdQdEJaZlVoWittakJTSnpa?=
 =?utf-8?B?T1dqYWJFNnM5ajZCcHZ3TjlVMFp3WTQxdElBbTg4NUdFMCs4VTREQTNXcDA5?=
 =?utf-8?B?NWdpYjBKTW5IZXcvcE5pUll3aXdRRFI3MmZJUUNHZnA2aE44eVZ5QmFSc1V3?=
 =?utf-8?B?NElqTGdTN21PRzAwV1FlZ0phUi8yNndUS2Y5TmtiaWFWbjBNak41NlgyMmhw?=
 =?utf-8?B?Y3dmZVIyYmJRcEd6dklubjNmeGlGY2JWeHFDenpQODlIWTdQVHpmR0kyUWFL?=
 =?utf-8?B?blJJZDVsTGJlZzV0ai84aEpiVmRRMCtGdDduYjh1WVAvMFF6b3dRaEQ2anQ4?=
 =?utf-8?B?M1NZdzhvQWx3My85OHVONTdWaHFYdGgva2k1TVo1L3ZKOVRmVHVJKzRzUEhz?=
 =?utf-8?B?ZHF0WEZaNzc5a1lhMWFyelVRd091cjlzbVhhTllJTnVsNTZwTjhKclBGVDZj?=
 =?utf-8?B?Z0JBY1M4SVhZaTB0VGdoRlhibWpnUnpnZHUrV1liT2NkSnhiUUIxUm5nN1pv?=
 =?utf-8?B?QUVESUVqMUZ1UGRLM3RXcVdrSzJMQi9HQjdBeUtGdkUvdFZpMU5Jd3NucU5l?=
 =?utf-8?B?NGFpNkpYaS8vdHZJTVJIU0YvY041WllXUUo1dER2ZWRWbCs5Tm5sNU9ubE1v?=
 =?utf-8?B?NnVMcnZCNStoMnp6QTlvWEVDS21rR1NCcEllaXBxNEJKMzVLem1ndWJtaHU5?=
 =?utf-8?B?YTF4TTdIYUpqUnlyRDYwN21BcVNQbjBIcDNST09OWUZTODBJYWFoWnJUa3Ex?=
 =?utf-8?B?Wk1leHdVN2NXTnlFa1g2QmFhYkh4K0VxRDk0Q0pXOXFFcVdQR2VxMHowUnAy?=
 =?utf-8?B?elBOQ3FQUUZXSUNTTEpwMGd1bkg2M0NOY1JINC84dnRRZ1VEUml1VUt4Zk5n?=
 =?utf-8?B?U2hBM2ZlMWFWekozSi8rVXBhSnhzZUxjUjA2M2wwRnhhTmdPMStaejhvZXVE?=
 =?utf-8?B?WEoyUDJ6aUlGYklXdGNmL3dnQytQZzRJS095ckNPZWJSbjE5UHZBTm5RR0FD?=
 =?utf-8?B?MC9jNk9HTWI1NzVOdXZvSDlzY3o2bFplVlF3S1pOdVd3cWliVEFzQXNNN251?=
 =?utf-8?B?d1Z5R3JYOThBUnNxQ1lsY0M2TFJhVHM2ZkZLQ0pNcmtHSWdYZHRJQWlXQUJq?=
 =?utf-8?B?bzMrM0E1bUs5d3NrMUpDcGQyd3UxVi84Ny9ML2Y4c2VhSE5RSFJ6eXFYNWN1?=
 =?utf-8?B?Q3V0ZmVINXZTN3MxV0ttaU9taGdLOGpuL0xPOWF4NEJSNW16blBGQkkrS3lO?=
 =?utf-8?B?eVpqczZtZ3ZVVS9QOXNCbHJ5ZjVGeS94TS85WUE3QVlUdGhpbEI2M3dtU1VI?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8959C5B80942824B9480C2102104CFF2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?R3U3V0lYWGQ4V3pmaW5lUElzcXhKdkJwYlVjdWxmc1lyUjE0QnFjaXNFWmZs?=
 =?utf-8?B?eWlySmpOL3oxcmRqMDkyWVhXWmdlS3U1Yi9ZdXRBeGRKT2ljWHlHVVBQTXlW?=
 =?utf-8?B?Qk03ajVHTDZPNTFwWlF6VFJNSkdpdzEyU0tYRGlycmxZckZNSnkyYmMvN09Y?=
 =?utf-8?B?RTdpMkFMcVFDWmFqczBLYW5TZHJNODM4ZmszbGd2b0krcmhRNzBITWhFVjk5?=
 =?utf-8?B?bFJpZVcvV0FNLy9jT0c5akwyQXorMnE4OThMUUxQWGFOTS9Da1VqU0llL1pP?=
 =?utf-8?B?MVRaY0NkYXVJUG5aZ3QyQnR3MUtvb0Nob3A5ZnRFbnRqSVFzb01CYU00K2M5?=
 =?utf-8?B?dTJSellqS0w3WU9KcTdhK013ejdZS2VUc2UwdXdONXZ4QjNXc01iQXBYNVpa?=
 =?utf-8?B?MS9UOXVqaTBOcHhSeW0yM1BMbzhCSi9rNDFCc0R0ck9aVjhycDhPZElxeUti?=
 =?utf-8?B?aWQwcnl4K3BabGRvck1HR2hPSS82VjlYMy9qQXB0cWd0UUxlTWxqbWdWc3hZ?=
 =?utf-8?B?Nit1Q0ptcm81cGRpN1VWM2tXd2NyQ0NBSTVCVE5JVnlQTWoyTGNEOFNndzdI?=
 =?utf-8?B?bUJKS1hvSFRROVFNM1Q2YUZ5UlR6d1l6b2h6aGFrZDF6OEY5YXg4S3EvSUxR?=
 =?utf-8?B?cGtmUFc5OWRka2NHNnhXLzYrRHFKckt2Q1hwMVJwS3I1WmZQQTlqc3BicTVM?=
 =?utf-8?B?ejZ4cDRlOUJndU5tN3ZPYVU5RFFzNTNvMUZWRlZSTW9vQ214eGZNMWMxWlB3?=
 =?utf-8?B?N3JpaUxkQmtud3BJdnVIUTQzek1Nakw0VG1LVW9MZ1ByY3NmOWd4QVpFSW5u?=
 =?utf-8?B?R3ZtN21CMnRjY2tmTWhiZGdvbXFBNlllZ3RxaU1pdHYzU0hwbGQzZGxWMTkv?=
 =?utf-8?B?Z0h1bFhCUzJFNnpwRURENjhVTktUT3ZJQzdXSFFCaCs4cDdpYXZvTVV1WmtI?=
 =?utf-8?B?Rkp1c0Jmbk93R2RXR21hYUVjZkRINGpjdE5VVU5qcndTV3hUKzBEVkRsVTNJ?=
 =?utf-8?B?UmtaV1ZsN1luTldWdXFsV3U5TE1DYVFGejVpRUw5Q2pXY01QRHcrMXlYeXEw?=
 =?utf-8?B?SmFDOFYrMnkwK1Nzb1lyQWFmYU1vaFc0SXhaeDczdzhibzBSUkNMQXgzOW51?=
 =?utf-8?B?ZmhDMDNpaVhqRzE0aTBiQmlacTlRYXJqeXMwUFBRaGtVRk1vTW5xTlI3SHk4?=
 =?utf-8?B?NmF5bFBPY0tuTWNYT0ZkNVpmQXFzSG9veHExcHRyRE96eURsRGNIajJRN1lo?=
 =?utf-8?B?SENHdEs2YWVuRnByRlhLVCtWQjhOakpUQmdjUERPZzFKZ04vZWRudzYyNEhy?=
 =?utf-8?Q?sL63A9ouSU3dN3IP6iu4M4BgsdDx1TiHAv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e896587-7f4d-4fbd-9761-08dbe9d67c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 14:39:21.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f20fNo9+twOkvpjE5nx7BIIlK8NomB9eIr2TESn6bok5lNUe4kd6SKIRMuL8Qkjgksqw0s1DkAxLAF0Z7BfyjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_14,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=980 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200102
X-Proofpoint-GUID: pDIZI4LYVgLTtXG_GoEzjSFFo-yLj4Jy
X-Proofpoint-ORIG-GUID: pDIZI4LYVgLTtXG_GoEzjSFFo-yLj4Jy

DQoNCj4gT24gTm92IDIwLCAyMDIzLCBhdCA5OjM34oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxi
cmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gU3VuLCAxOSBOb3YgMjAyMyAxODo1
NjoxNyAtMDUwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+PiBUaGUgbmV3IGRpcmVjdG9yeSBvZmZz
ZXQgaGVscGVycyBkb24ndCBjb25mb3JtIHdpdGggdGhlIGNvbnZlbnRpb24NCj4+IG9mIGdldGRl
bnRzKCkgcmV0dXJuaW5nIG5vIG1vcmUgZW50cmllcyBvbmNlIGEgZGlyZWN0b3J5IGZpbGUNCj4+
IGRlc2NyaXB0b3IgaGFzIHJlYWNoZWQgdGhlIGN1cnJlbnQgZW5kLW9mLWRpcmVjdG9yeS4NCj4+
IA0KPj4gVG8gYWRkcmVzcyB0aGlzLCBjb3B5IHRoZSBsb2dpYyBmcm9tIGRjYWNoZV9yZWFkZGly
KCkgdG8gbWFyayB0aGUNCj4+IG9wZW4gZGlyZWN0b3J5IGZpbGUgZGVzY3JpcHRvciBvbmNlIEVP
RCBoYXMgYmVlbiByZWFjaGVkLiBTZWVraW5nDQo+PiByZXNldHMgdGhlIG1hcmsuDQo+PiANCj4+
IFsuLi5dDQo+IA0KPiBTaG91bGQgZml4IHRoZSByZWdyZXNzaW9uIHJlcG9ydCBJIGFsc28gcmVj
ZWl2ZWQgZWFybGllciB0b2RheS4NCg0KWW91IG1lYW4gdGhpcyBvbmU/DQoNCmh0dHBzOi8vYnVn
emlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE4MTQ3DQoNCkl0IGZlZWxzIGxpa2Ug
aXQgaXMgc2ltaWxhciBpZiBub3QgdGhlIHNhbWUuDQoNCg0KPiBUaGFua3MgZm9yIHRoZQ0KPiBy
ZXZpZXdzIHdpdGggTFBDIGFuZCBNUyBJIGNvdWxkbid0IHJlYWxseSBkbyBhbnkgbWVhbmluZ2Z1
bCByZXZpZXcuDQo+IA0KPiAtLS0NCj4gDQo+IEFwcGxpZWQgdG8gdGhlIHZmcy5maXhlcyBicmFu
Y2ggb2YgdGhlIHZmcy92ZnMuZ2l0IHRyZWUuDQo+IFBhdGNoZXMgaW4gdGhlIHZmcy5maXhlcyBi
cmFuY2ggc2hvdWxkIGFwcGVhciBpbiBsaW51eC1uZXh0IHNvb24uDQo+IA0KPiBQbGVhc2UgcmVw
b3J0IGFueSBvdXRzdGFuZGluZyBidWdzIHRoYXQgd2VyZSBtaXNzZWQgZHVyaW5nIHJldmlldyBp
biBhDQo+IG5ldyByZXZpZXcgdG8gdGhlIG9yaWdpbmFsIHBhdGNoIHNlcmllcyBhbGxvd2luZyB1
cyB0byBkcm9wIGl0Lg0KPiANCj4gSXQncyBlbmNvdXJhZ2VkIHRvIHByb3ZpZGUgQWNrZWQtYnlz
IGFuZCBSZXZpZXdlZC1ieXMgZXZlbiB0aG91Z2ggdGhlDQo+IHBhdGNoIGhhcyBub3cgYmVlbiBh
cHBsaWVkLiBJZiBwb3NzaWJsZSBwYXRjaCB0cmFpbGVycyB3aWxsIGJlIHVwZGF0ZWQuDQo+IA0K
PiBOb3RlIHRoYXQgY29tbWl0IGhhc2hlcyBzaG93biBiZWxvdyBhcmUgc3ViamVjdCB0byBjaGFu
Z2UgZHVlIHRvIHJlYmFzZSwNCj4gdHJhaWxlciB1cGRhdGVzIG9yIHNpbWlsYXIuIElmIGluIGRv
dWJ0LCBwbGVhc2UgY2hlY2sgdGhlIGxpc3RlZCBicmFuY2guDQo+IA0KPiB0cmVlOiAgIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Zmcy92ZnMuZ2l0DQo+
IGJyYW5jaDogdmZzLmZpeGVzDQo+IA0KPiBbMS8xXSBsaWJmczogZ2V0ZGVudHMoKSBzaG91bGQg
cmV0dXJuIDAgYWZ0ZXIgcmVhY2hpbmcgRU9EDQo+ICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy92ZnMvdmZzL2MvNzk2NDMyZWZhYjFlDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

