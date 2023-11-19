Return-Path: <linux-fsdevel+bounces-3169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458067F08D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 21:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75561F218EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 20:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2BD19BD7;
	Sun, 19 Nov 2023 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ELU92YKb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yz/xCreQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F7AC6
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 12:22:56 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJJlvRP007181;
	Sun, 19 Nov 2023 20:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=euRFEAWw1KTIz4VXqsawrg3Eqw5aYUt5jiA1KvUqc0E=;
 b=ELU92YKbF6+jri1JL8i4AFxeyrYd10DGCt+PotHidWgvukyoysAOmhbq0RtkdTL1PfkO
 mZr4YmXePOAighFkqEbKXPYKZWyWvR8rZud6JngDUMruxHYuO++bRr7ntM3AX1M9VwpS
 92rFC0INXW45emrngWZ91xiI9wD8SeJ6gmFP1Yne+4oJquqS4CoZvMPKQAfJ6WYA4/6G
 gfxNcEqli5d4+o+dAo72vNJORl+XOEmQ7l/hdaXpE5tho46I8XJ7YB5BPuXLcadWrDZ5
 i5e1g+N9llk+efo8HhFbc8L8lZ7owwawvYlhvGawPTQUVA4vrSgyLpM2sFF5gV2YoZg7 sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvu9g24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 20:22:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJIMM12002363;
	Sun, 19 Nov 2023 20:22:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq4ht4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 20:22:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7KkmbS5EUggSytmgt8Hor/DuCS3b+CMJmFiRTpsZmr5GtuTSQEzAN7tTfvkKCau+t5WGckb11Q9z8RnRkh52Pa3ZwTk6y15aUxvUps8nEGYc1qtJN0A0ZRxHltBCE3nc9vSP0kr20TV3ik8Uk8faETm/cW6URYa1UT++hVzQBclheUPHfSpNczQy503i1WJcH2n8llTcH1WrtV02/3XuUGKI1egpDwMX2QKH3X5k4izElqDnrocAk/3Iur6TLK+h8dZRwSThiBknHmmbdcIV3Y2sm4Wr5f3XOWcWISuXbP1sQOU0i5/7roXu09BO7s57FKOEHto5ylQVdRPDMXX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euRFEAWw1KTIz4VXqsawrg3Eqw5aYUt5jiA1KvUqc0E=;
 b=krkATcvMm5mq0iZCGgGenaiGxquyqqBZJIypC6rJdobsvDli6VkD7fR8B+UlQG4EeU/XQUR9GhHWD/LC8byelk4o5UrcT0VEF3YmRqtbMgXBiS2jUu+v2UK1Eg18KboHu5c5imAbJqq774EHh4ltYZsciUHUyVr9RDrT5yzfvgajdZi3xXQy2Ce9LdSw7s/8IIB34FSIcd81oSTPDtv1toE5otNHk7FWPBdLSbSz5nWC23l/zjKs6vv4H34S7FSZXYrypWmKTd1wr8WyiTKT6taC7D1/peNucgtDhhFPuQ5qipnpsBsBeCqfgBYEfkSVVFwDmysOXYzWvHiz+CEEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euRFEAWw1KTIz4VXqsawrg3Eqw5aYUt5jiA1KvUqc0E=;
 b=Yz/xCreQ6LKVYqN1uyxGgjo6ZbFq9xzt2z2x7PLgPw/Nlq2Wqqd/nYkeZynC8U5vJ7ApNLKYuyt6S5/d7lLVhy9RB9D7B1S/Yhv1cpwl0kkO2V5jNqlve1b1NvTlWIB5oiu/Inuk3SqslUCq4ckOysddgonhHoYaPjSiwL0NyzY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7440.namprd10.prod.outlook.com (2603:10b6:610:18c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Sun, 19 Nov
 2023 20:22:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Sun, 19 Nov 2023
 20:22:30 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Chuck Lever <cel@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>, Jeff
 Layton <jlayton@redhat.com>,
        Tavian Barnes <tavianator@tavianator.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>
Subject: Re: [PATCH v3] libfs: getdents() should return 0 after reaching EOD
Thread-Topic: [PATCH v3] libfs: getdents() should return 0 after reaching EOD
Thread-Index: AQHaGlYbXJUwXveqVUyEMySCTkOG77CAT+0AgABrfgCAAUpXAIAAEcKA
Date: Sun, 19 Nov 2023 20:22:30 +0000
Message-ID: <46914DA1-E529-43FD-97B6-F995AD933156@oracle.com>
References: 
 <170033563101.235981.14540963282243913866.stgit@bazille.1015granger.net>
 <ZVk2m1scRfy4Xq0C@tissot.1015granger.net> <20231118233626.GH1957730@ZenIV>
 <8F8B8E49-7AC9-4ECE-9CAE-8512D9C1DACB@oracle.com>
In-Reply-To: <8F8B8E49-7AC9-4ECE-9CAE-8512D9C1DACB@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB7440:EE_
x-ms-office365-filtering-correlation-id: 15f07432-cd99-48d5-c000-08dbe93d414e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Uqv4UQR89nBgKrJr0iDlVzYvVB1+s3nazb02ZtAqjZQSQyz5dkpNnmstqfQ1biubwKo9PEoKAZzxrt2YW1/rV+LNde6IjGd1ck4WBnJ3n+6w+4mfbgDdm50rb2ma8limL2IQAHVlbq4/JMyQJmkjEYRjE4D0Ge1XK1yrHD2P7ktp7Fo4Z3NHh0L9KEOAyPNhbeznR9ZhUSeRcqYceieH31r9Re9wB0rKKpQ0ciyiqHeiiFgDW3Dk9BIGEBEI+pgR2zZ08oEPtAMUuSUb/HiUn8QXyp2wTKi3nVti6l51qrrGjK4KJZgvjrAW3F1EywTJex2P+wCYS7lNNQHtM04PPwfaPodR4giRHdEtPHnirt89/HJMascjT4GzB3taT23oj1rrK0JtepMnLAbIxjTSiaVmyGj/Xf0unDiyTF4H7emAckbBl7TmIJyMQ2q/zzEgwmVPpzEoWXwELUCpAA3gqioNxpcsALbdb3RS5Tg1aeusEdVN6QkWmLjlkbBX9CCSnA9bPY1DRqBLziTYodI+pFEN/RaZMImdJ8MmogNi431Jn9ILxksR1J0rX986vI9oP0z/1sIQbXDPnBdswtQ/HHRXxKRcFnowYuC4MYN9bZT9tJ8X7NMYAZcUKDOdfDPHF5IqeB4Q96PFmsHP+8rAfQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38070700009)(86362001)(71200400001)(91956017)(6486002)(6506007)(76116006)(66556008)(66476007)(66446008)(64756008)(6916009)(66946007)(316002)(54906003)(36756003)(33656002)(122000001)(2616005)(53546011)(6512007)(26005)(83380400001)(2906002)(41300700001)(478600001)(5660300002)(38100700002)(8936002)(8676002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eFRvUE1yR3FlZ0NBNGJCVWx2YWVvcWkxYjNRaCtPKy83a2I3U1V2NjRSNi8z?=
 =?utf-8?B?OFB0Rk1LeXo3T05yWUNlMysrN0NDMDQxMEp6RFJMR3JHUXFEMEFuMUxJSGtp?=
 =?utf-8?B?bm1nUHNreS9HVUlWeEN2SzJZTS82T2lMNjRHb0xIMjBIbVB6UXUxYng4V09W?=
 =?utf-8?B?bnhpMTV3eEM2aEt5S2FreGlKOVIxQlZ4dDFXZEhheTgrV24rTzlGblY0bTFo?=
 =?utf-8?B?L0tEc1RlKy83bC9lV2RTNHM0K1RoclIrZjdDMkp5a0ZuL1hnWUpsQWxqeUxU?=
 =?utf-8?B?ZTdUSVp6YXBNeGRRaThzaW90RTJnNkY4TEtOSmNYbGYySGx5Y092bVV0MDBL?=
 =?utf-8?B?T01OY0EzWEEybmNWUVJ1b0dCNmFMVi9qZFpkYUtWTXhvd3N0aEppVkJrR21J?=
 =?utf-8?B?WXAxV2crR0lacU5mbkhCVHdSQk9VRWFjTzVMQnVuSzlYUzMxdXVFNE1Ob08z?=
 =?utf-8?B?QWRoZHJIYm01VzE3dzVZRjExSGwzb1o5V2xBVTRGYS96YVdmUGY4V2RRdTFE?=
 =?utf-8?B?UDBuR3N6QXVzMzZpemdWS0NnSERXVm5yVHk4dEZuTEhYYlVvYVYxYXkybXpz?=
 =?utf-8?B?OXQ3MlpEWEw2Tmh3QTRrZ0tVVFVSLzQ1SjVCT3pMWFB0ckhOVEhmR3JzdElP?=
 =?utf-8?B?VlVTTGY3NHlJeTM2TE1SQUt5VVhSL1h0Y0hqWXFtOVlHbVdONllHR2FVeVgw?=
 =?utf-8?B?Wm15VHg2cWc0eWNCSVpPV24wYjBlQVUzNmJIakozazZyVERndDh3WEs5SVNp?=
 =?utf-8?B?b0l5UmMwTlFPVjR5dGpRSzluR01iMUNRRWthQnJ2Ylg2b2p5WHFQTE9UWlVr?=
 =?utf-8?B?REZnc2JXSmRML1A4WVF6RWpCZ1d2MWJicmZTQ3NxTVpORjhoaVJieGtOSlN0?=
 =?utf-8?B?MWtVM0VTNHVhSVNLK09RSVBtWDBqaVUyYloybmIwUEx6aE1sWHVRaUhkOHRq?=
 =?utf-8?B?Z3BRd0ZWUFJveVhueHN6YzRsUUozN1VjalRUSlIvZ3VYVy8wU21KZXVCemZE?=
 =?utf-8?B?TzF0a09uaGRkS2pOanlmczk2dHZIb1czQ2xaWjV4NVZndWU3QTJEL1JmaGZz?=
 =?utf-8?B?enN1SEhYaVB0K1lPQ2hTaVRhVUtmcEJDQnVvMlFRWDU5cEZxTlRWUG5LSUVH?=
 =?utf-8?B?QU1QOGx2bnlIRnBrM201dkttbEdtZlpUV2JFL3A1ZzhoaitsR0ZLbjlJUy9s?=
 =?utf-8?B?OTU3b3BRajlVMmVhOXZtREFJRnh0dEVkZ055VHZURmNMZkxjMkU1V2o1cWNL?=
 =?utf-8?B?NUlRSktWTFN4NHd0VGRDaDljV1dsSEVxcWk2R1FOamRlNkVGQnEzbUFaNUJD?=
 =?utf-8?B?ejdCRnJXNzlYZGU1REllK0RGSi9jbUJlSitrWDJmb3gvaG5CaHZteHZhWjQ3?=
 =?utf-8?B?T0U5RVlvcnVaKzNTZlZNeXRCU3lyL0JWM3NCNngxaUYwT2ppbWJLNHhVS2pH?=
 =?utf-8?B?eDdiaTkydThSbXpDMzBsemNHbVlFVFpjVE9tZkNsTnM1L3MwZnZrZVhSUWVI?=
 =?utf-8?B?OStRd2QrdllJbXFPUGxoSGlIS2c5bW9aT2xOYldNN2xsQWtDRUMrck80QjBI?=
 =?utf-8?B?SzRaOHdPY0hPVSt0clgwdjBVZlJidGNsZU1WSGNMQkVxQUJvZnR2Z0FTYnZQ?=
 =?utf-8?B?ODNPMk1HS01pa2tLUVo0OHpFbGdjNTJQUUlXSjFnNUg0NS9GZ3owQng2bVlT?=
 =?utf-8?B?eWdqaEYvclJELzNJdUh1WGNoRmhiZHI0RlNsNXNValB6RU15NjViQ2tZQ0FR?=
 =?utf-8?B?MzlTNnMyaGpJNTE4bUFudWxMSTliWjBsb0FWNmpVRW03czU3YnZZV3NlZTZy?=
 =?utf-8?B?blVSOTJ5ck1OSUkxdFk4TWpoNWJYcVc4aFFXYlhGcXVoNEJWMnRGVnAwVXdH?=
 =?utf-8?B?Vkl6aENZeEZFOU5FaEpMZEJTTGxUTVNKdFh6YTM0YXNWVmVaejhpVEx3SlBZ?=
 =?utf-8?B?bTB1VHoxS2loQlRQNnRnQXhNMHlvL0Z4NjNlMjVWU25xSnJ1eHRHUVRhWXhL?=
 =?utf-8?B?WDJtVUdKM1AxMy9lSEppdWJYS1FaclBsT2g4QnhXbkVnNUtncG8wN3IwZW9k?=
 =?utf-8?B?MFJzNzZCSG5sU1U4QkhLNGJWUWZLSzM5emVHUEpHZTNmSGcwNlovTW1xaFBI?=
 =?utf-8?B?R0owczVLSXdmQThWMnh4azhkOFVIbTZZZ0xJTG5pZUhoMVhNZkhwdnZXM2Y4?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C8AAE0FA7753B4CBE5DF7144F95E619@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?QUJUMENZaGFVM241bkxOVnlUMU5iVDNpdmlkZWlrVlBjRHJLNGdWbHlaRWtL?=
 =?utf-8?B?Wkp1TWVjSDZTMVhRUjNONmpvOXhVblVDUGovRUxidGdwRGlyTUd6V3ZjakJ0?=
 =?utf-8?B?R2JGU2ZtVWVBd2VuRWg3SmVFT3BFMnFPWnBCeTlxWmNyYVJrZHpaa3prVWVo?=
 =?utf-8?B?YXc2R2lNMzVMczQ4WHk1Q2hCWUptV3hMakl3RDIzN1RTeVpOU0VnZDdMSXl0?=
 =?utf-8?B?V2dNVW1QK3RVNW5wZHVMRVZXdSszQUVLd0RaT3dlQ3loQmxOMzM0ckRSMkxB?=
 =?utf-8?B?SXB3b3Jkd2NPN1d4YlI1MXNrcklTSUt6K1lrOGFmTDg0aE5LYnRYTjNPaUhR?=
 =?utf-8?B?U2hISXJsaWxpekFsV2JWbEVtQitNT241SFRseUxYQUdZeUdSR3RtTWxPd2t0?=
 =?utf-8?B?R3hCTzFyeGVxa2xpNkdtY0VTSEJpR1NCWGlNMDhtTTBCWWtTSTNGNm9Pa3Iw?=
 =?utf-8?B?NGtsU29FRW1UTWx4U1JmNXFiU0YrWTFrODk1TGhkQnpXRWF4RExKMG1zTk9E?=
 =?utf-8?B?MDNXTWdOY3cxcUhHbkZQdzNjQ044eXE1dkd3VndFdlI0M2FWM3Q3Yi9Wa0tQ?=
 =?utf-8?B?QmpUWFhCdjJreXhkc3FoMDNPTWJwOU9BZWk2MXErVndzZHF3aFZBeUcrU1Ra?=
 =?utf-8?B?eFJJc1BackxEUVNDVEZvcTZGVy9jazNGVjM1ay9ZVXhkMzZtdmZnNGQxYmQy?=
 =?utf-8?B?QVN4aGRZWUp5dE05MElTT0hBMWloUHNVQytxWUNTbVlqUFhjV1VYdS9YYkFM?=
 =?utf-8?B?YnFjOGpqNWNDQTFESWhmUGZ4YUVyempFVHZzM2UyMkovRVZyS1dLeVdyWS9X?=
 =?utf-8?B?YjBDTU5sMitRT2EvSUFGQTJ2NC9reTBJWDRNSnZGOFlpUldJLytlQ0N4MGh0?=
 =?utf-8?B?RnhZSUx3MnZ3N3dEbmJSZXUwcmp1b2xkUXNwbDlkbWVSMVpsREJyd1ZFeDc2?=
 =?utf-8?B?Mi90YmEyaGE4RHdaZjd1WVA3cXdidHVndDlFMlk3V3FiOXVRZ0pDVzNDNmlM?=
 =?utf-8?B?UDBVVStxNEY3V0VCbmdKdCtwcUlnYWoyOEdnWW01ZmdYRWFuUU5SNmJuNEZN?=
 =?utf-8?B?OW0rcUxvZTYvYVAxbFR3RzdhTlR0RzZuZ0QwLys5ZGpOUG1Ga2xSdHB6M0Ux?=
 =?utf-8?B?T0xveHNRY3czWVlmUk9raUt3anBMUUpGZ1JmUUdGUzdEUDFkaGk4a095RW9B?=
 =?utf-8?B?WDZmdWVtazdPTy9GQ2xBaVhxbEFPdTFwZlUraHU0VTV0RjJUOTA2ZVJuQWZ5?=
 =?utf-8?B?LzhtZHhscU1rMnlVNnNrdGpidGp5R2tJek40TXNtS0xoeXBoTEwvcEMveUw1?=
 =?utf-8?B?bnU3OVZUWTE5OHBXYTllc1JZU05WU0VUMVZYaWh2OHNRZWFlZFJtWkxpcnlm?=
 =?utf-8?B?RGhIQzkvci9GR2c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f07432-cd99-48d5-c000-08dbe93d414e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2023 20:22:30.0955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08mvzVrLWETx6IBrO2PlRLcjtfVCGbbRODBei/nlWJbFLA8eGZfzvAZN21x05ggQAXBiRMtZQCTZRttXq0k+SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_18,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=662 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311190156
X-Proofpoint-GUID: mU9g3Tsbgma4opT3bwRNeUWqgtfF9LWl
X-Proofpoint-ORIG-GUID: mU9g3Tsbgma4opT3bwRNeUWqgtfF9LWl

DQoNCj4gT24gTm92IDE5LCAyMDIzLCBhdCAyOjE44oCvUE0sIENodWNrIExldmVyIElJSSA8Y2h1
Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4+IE9uIE5vdiAxOCwgMjAyMywg
YXQgNjozNuKAr1BNLCBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4gd3JvdGU6DQo+
PiANCj4+IE9uIFNhdCwgTm92IDE4LCAyMDIzIGF0IDA1OjExOjM5UE0gLTA1MDAsIENodWNrIExl
dmVyIHdyb3RlOg0KPj4gDQo+Pj4gV2UgZG9uJ3QgaG9sZCBmX3Bvc19sb2NrIGluIG9mZnNldF9k
aXJfbGxzZWVrKCksIHRob3VnaC4NCj4+IA0KPj4gV2UnZCBiZXR0ZXIuLi4gIFdoaWNoIGNhbGwg
Y2hhaW4gbGVhZHMgdG8gaXQgd2l0aG91dCAtPmZfcG9zX2xvY2s/DQo+IA0KPiBJIGJhc2VkIHRo
YXQgY29tbWVudCBvbiBjb2RlIGF1ZGl0LiBJdCBkb2VzIG5vdCBhcHBlYXIgdG8gYmUNCj4gb2J2
aW91c2x5IGhlbGQgaW4gdGhpcyBjb2RlIHBhdGggb24gZmlyc3QgKG9yIHNlY29uZCkgcmVhZGlu
Zy4NCj4gDQo+IEhvd2V2ZXIsIGxldCBtZSBsb29rIGFnYWluLCBhbmQgdGVzdCB3aXRoIGxvY2tk
ZXBfYXNzZXJ0KCkgdG8NCj4gY29uZmlybS4NCg0KbG9ja2RlcCBhc3NlcnRpb24gZmFpbHVyZQ0K
DQpDYWxsIFRyYWNlOg0KIDxUQVNLPg0KID8gc2hvd19yZWdzKzB4NWQvMHg2NA0KID8gb2Zmc2V0
X2Rpcl9sbHNlZWsrMHgzOS8weGEzDQogPyBfX3dhcm4rMHhhYi8weDE1OA0KID8gcmVwb3J0X2J1
ZysweGQwLzB4MTQ0DQogPyBvZmZzZXRfZGlyX2xsc2VlaysweDM5LzB4YTMNCiA/IGhhbmRsZV9i
dWcrMHg0NS8weDc0DQogPyBleGNfaW52YWxpZF9vcCsweDE4LzB4NjgNCiA/IGFzbV9leGNfaW52
YWxpZF9vcCsweDFiLzB4MjANCiA/IG9mZnNldF9kaXJfbGxzZWVrKzB4MzkvMHhhMw0KID8gX19w
ZnhfbmZzM3N2Y19lbmNvZGVfZW50cnlwbHVzMysweDEwLzB4MTAgW25mc2RdDQogdmZzX2xsc2Vl
aysweDFmLzB4MzENCiBuZnNkX3JlYWRkaXIrMHg2NC8weGI3IFtuZnNkXQ0KIG5mc2QzX3Byb2Nf
cmVhZGRpcnBsdXMrMHhkZS8weDEyMiBbbmZzZF0NCiBuZnNkX2Rpc3BhdGNoKzB4ZTgvMHgxY2Yg
W25mc2RdDQogc3ZjX3Byb2Nlc3NfY29tbW9uKzB4NDNjLzB4NWQ2IFtzdW5ycGNdDQogPyBfX3Bm
eF9uZnNkX2Rpc3BhdGNoKzB4MTAvMHgxMCBbbmZzZF0NCiBzdmNfcHJvY2VzcysweGM2LzB4ZTMg
W3N1bnJwY10NCiBzdmNfaGFuZGxlX3hwcnQrMHgzNzEvMHg0MmYgW3N1bnJwY10NCiBzdmNfcmVj
disweDEwYi8weDE1NSBbc3VucnBjXQ0KIG5mc2QrMHhiMS8weGUzIFtuZnNkXQ0KID8gX19wZnhf
bmZzZCsweDEwLzB4MTAgW25mc2RdDQoga3RocmVhZCsweDExMy8weDExYg0KID8gX19wZnhfa3Ro
cmVhZCsweDEwLzB4MTANCiByZXRfZnJvbV9mb3JrKzB4MmEvMHg0Mw0KID8gX19wZnhfa3RocmVh
ZCsweDEwLzB4MTANCiByZXRfZnJvbV9mb3JrX2FzbSsweDFiLzB4MzANCiA8L1RBU0s+DQoNCg0K
LS0NCkNodWNrIExldmVyDQoNCg0K

