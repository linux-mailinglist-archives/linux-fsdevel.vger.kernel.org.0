Return-Path: <linux-fsdevel+bounces-3168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8A67F086E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 20:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599F91F225FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 19:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EEC18E03;
	Sun, 19 Nov 2023 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lk3ZlVZt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nY9CKaTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED00F98
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 11:19:33 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJH3D5l005141;
	Sun, 19 Nov 2023 19:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Z2vOE+MymujsHaS0Ovy2yQqynSv07Gavm4A+LDR0YKI=;
 b=Lk3ZlVZtsYs8mi+QBUJN2Z7K0yI+yHlof2faTirNdeOG0NesEF2hj0GUxabTPSOoZdmk
 pQjT9Wrdmr62ozqfeiPsXrCjzVihE2FrHauwMlRavSBaNHflO+xJrJnczreVW4jzWhIS
 DdLVj1rLgXsbga6oov5W5zssgjrvd7XFWPp/tbEGhC9RLhl1eCWODooKcdUmXc2vidEK
 lwAREJabHHWKiG3CXYA5O9eiy64esMHf9NpsUzv29WXBW1nGFzS2USGBVIJwHapDvgdZ
 BJMsc8Ie0KUuWdiwRIRKD7bZ5U9LFpGyV8DkQwvMUMIBeaKE42dGlE+DmosgASBT120w 8w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uen5b9eaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 19:19:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJJ9Rr0023479;
	Sun, 19 Nov 2023 19:19:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq4gfph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 19:19:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtU7o94alvPKJFoxFVjkXOc6tJfpepE2JUvwth9wj5pVDbWwy1BiHXzT0GBGSg57nM7wrnAOfiqjkZxqMk4f6772VT3mR/8bgJHdH31LiUoY8aPG5eLIhKUjm8G/IsrN6NOwNvOT+6SA+OevhkUyZX22zpZSI5Ks8T80//Ns3VrlNsKYpaCMnOEiJzNkxW19hFQ2z09q7dBr8LPW9skQ9eSgbJWgfsJHPAqE0J/xahNKBYlyF1HE/31NzxsB0WUA/22me7zsttCO2sCePzQ2x6V2NfeCTAqYSaL/5abopGl914hqbe5Zo2KXCD3pKwMkGfzNRTOp9spyqobprI5BvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2vOE+MymujsHaS0Ovy2yQqynSv07Gavm4A+LDR0YKI=;
 b=BsA3SVBizcg4TttbS0TAxI6bHRcg9H3kyGssufdrN+Cync3L9D8Fc4xZWc3p61nU9TrUVqKJOCsatlLoQnm9QGEfStHcyQAX2VGBrwxUzdnEGJjBdRNdO7PYzQPHIFIAdtLkJZQ3LZimm6mCwa7vrD1iKHbgtEhy8X3z/lnrEK2j62TxGIU1G7+cY97i89KVC1IAo9Zbop5yvBdp2IobMrF2CwUElOefnKsymnhw1/yxnX0mCWaiixdnvWQoskjBNFYamcW5S3EaDVpfxunrOltwBSsdMBG3BCRaJ5d5sIn5NUXLCaBr7deSzahgDGq1/tUwdIZFmMlGPfHGGGrJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2vOE+MymujsHaS0Ovy2yQqynSv07Gavm4A+LDR0YKI=;
 b=nY9CKaTsHgkrqXMrtuxc2t4CiW+qYxs6KHfuNbFbM9NWG0v0b6d6Yc5+hWq9fSkojhLs1PjG5WzqZxgtkvHRny0cQnMTFe66BDf/cVwjbk0atTYKHtAfsH9tbPODRLHnsefQAoGLFtsq+IKrs3H7x75DZHkgUx2u+SmTuTYpTrs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5294.namprd10.prod.outlook.com (2603:10b6:5:3b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Sun, 19 Nov
 2023 19:18:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Sun, 19 Nov 2023
 19:18:56 +0000
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
Thread-Index: AQHaGlYbXJUwXveqVUyEMySCTkOG77CAT+0AgABrfgCAAUpXAA==
Date: Sun, 19 Nov 2023 19:18:56 +0000
Message-ID: <8F8B8E49-7AC9-4ECE-9CAE-8512D9C1DACB@oracle.com>
References: 
 <170033563101.235981.14540963282243913866.stgit@bazille.1015granger.net>
 <ZVk2m1scRfy4Xq0C@tissot.1015granger.net> <20231118233626.GH1957730@ZenIV>
In-Reply-To: <20231118233626.GH1957730@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5294:EE_
x-ms-office365-filtering-correlation-id: b0cfa01f-dc08-4cda-0037-08dbe934606c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QOmITDS+BD4KyxoDjK06oEeXoT8w8zjH1o4fgkbkyRbAxtQav+nB8l05aYE6WabOaiihf7IlafDjjI3r8iY4OLTM8rOgVnKNrtIaf51voWRvONzXJ/dbQnJCSL2TvsfBOrn3p9zyHZZtwFG4AZ9TQ65YeZRM2ae5ny4aemn+YaDEmBqeUgXU+080oWInCYRkpVvjYG2qNfNwsETi71bZVzV0h/nLEUC1wQABvlxjjCcO3gdAQ39KJzupQeWTWsSCbIyHWkLg1utXqZ9Vdw1Ez5CVzcejzzyaUloqe8cIDxSQSkwx/FWALGxXWqPKC4OBcVgn46g4TQ3xIse8sEHf3R68PO6USr34x+3096/3r3c9zDQV2YHxg5zBupkSZCF2NA/c4lPB+9O0pBPbZvCe0VlyUHp5nj2tfsn0GRzONY0gqEYQVglXMHQDVp1SsP8VnXuwg9TSUPGoaFfpDL7WVxBGykQu4zYFjLC1VQwcAyYV98a3DU8Afg6/rtbpujuQqp1KRBNMKXpoeeK4UvHPO8iegtgsJ5h0DVCSMh2gEWLmBcfr1kha2w3KyaZphFX7QMjZpMwXpNbkl8M3nRKnxUWNdJngp3Iw1TE8PTebmckyvP8wgM4GeeufZeSpx+WQ3Es74NTf7OLuCBHT6Ba/3A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66476007)(66446008)(66556008)(66946007)(91956017)(76116006)(64756008)(54906003)(6916009)(316002)(53546011)(6512007)(36756003)(71200400001)(2616005)(6506007)(478600001)(38070700009)(6486002)(26005)(38100700002)(122000001)(83380400001)(33656002)(86362001)(2906002)(5660300002)(4744005)(4326008)(8676002)(8936002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T3hpWFFZd3hmZFpLUWdyeDFiWStjUVlZaHg1NlBQZGh1ajYvNlZJRjhyanF0?=
 =?utf-8?B?VWVVbmFyOFZIWTlGMWdiZkRJNS85dkh0QlJpRGtDQzJtbWNiQmVVdDJ1bDZa?=
 =?utf-8?B?eFlpb3JnL0pIdDZRcHpQeTdmODNMbEdRVXRaWmc0Y0FacVFiV245dzdYT0pn?=
 =?utf-8?B?enhEb1YvNHBWeDEyR25CYnh3OG8vT1Z6YlpwdW52K3I3QXZkMlhHZnJZNUFN?=
 =?utf-8?B?TUxFM0NpWmVkT09TUzJ0RTUvMzllTmRuNjV4S0dIVi9qd3k1K3I2T0dsMDcx?=
 =?utf-8?B?Qi9wenIvSG5welhzeS9TNEdkOFpzNVhpVUIxRnJIdmdJVFlmSTluZURxMEVp?=
 =?utf-8?B?KysyYTVEUHg2WDhUVGRnUGxjbDl0ZGFoVjFjOVhoM3JhOEpnTUptNTVGNnBs?=
 =?utf-8?B?U0R0bEVueDNoVXZLSEgyQlNHaG80bThIcG03OWh0eVdZZjY5elA5YU1laFRN?=
 =?utf-8?B?eGNaWldCZm1WMnpWWVYzMUY1TzE3Q2srZ0lUU281aDJwVWdNUWpqNkI0bjVi?=
 =?utf-8?B?Sm9Oc3lCVGQ4bnpHald2OEszN0VJZkMxQ1lUR09DaHBxbzZqcFd3bWU1UWhs?=
 =?utf-8?B?UWU4ejlnMmxTcHZzWkJkdzlnYUxlSHVhRlhVQ0RLOFRSREQrK1I4OFRwelZj?=
 =?utf-8?B?ZmlFRmlHdnk4SmJ4U0UxVlJOK3RvYmd6QWFaREVuVXJ5b2N2cTFxdXg1dHlL?=
 =?utf-8?B?bk1Wc1lJb0pIU0Q1UWJNL1J1ZGlMMDJDS25Fc200SlBDeDk1cTMyUkxoaE56?=
 =?utf-8?B?V2srQWg2OHo4eTdBZmQyLzdxaGppTm4zNTBwejlXMXQ4SnZDSWt0UlRCZXJU?=
 =?utf-8?B?aDg3aDYzMVJTNkFzc3NQM0J2U0JUTUJBeHlUZm8wUy8xdDFldHlKRW4wdEJx?=
 =?utf-8?B?Q0ZqRDlqWmkzdDE2bllnaWJJQzVJRlRaeHU2WkhNNWZFZ1pvamZiU0dLRStO?=
 =?utf-8?B?aXlXSmREWVhMaFVGQ3BMbkNhbFp5VGVKNUpxYVlrSTNtTW5HdEJUbjA1Rlg4?=
 =?utf-8?B?YnBLTjZOOXUvK2ordWV2aXM5a3FJbVVhYytwRXFVVnh3WXQ0K21hTTlCVng1?=
 =?utf-8?B?UyttRnowK1VvTDFuTGZGQWRoNjZaYVJONllqUDZwTzY1OWRjbDZOeFIxei9E?=
 =?utf-8?B?L25UOW90cnFubnZueFEzLzR3Qk1WbzZZWXNtZFpHMEpTZ1Yxb0ExRDNqUUxU?=
 =?utf-8?B?Q2liTXRGRlpNemtCOEZPK3g4ZmtxZllvRFdYeFdUMU5rcFBrVytvbHlBbE5i?=
 =?utf-8?B?U21JdER1U1cvUHdBYlVuTlJENTQ2NUc1R0dxT2s0aVhwK3AzNi9kSTVXZ2xV?=
 =?utf-8?B?b1RuenFaaURIclo5YzlUWmZvZ05TVnRId1l0bjhuc0s1dC9SS2YvMWY5TkZq?=
 =?utf-8?B?elBqSXB3clI1dlkwVjR6OEgvKzZ4WUJqbUJzVTM3YmZKVDFoREhSaEV3dUNr?=
 =?utf-8?B?MG1PWUZJdjNOSThITUQ4Y3RNdHNQYmJHZ1pmN3JoTUNKSXFueEphZnh6aHFm?=
 =?utf-8?B?dEdQR05ZRFFpK3AycVNadnBFSUc4NzZjTndiTEJKa2xINlJkR0NoNldnZzVi?=
 =?utf-8?B?eDlTZ2tldVhCRU4wcXVWdHVFTDFvQmVsSnZKUzRmMDB6SlNnbTFwOERwZ3du?=
 =?utf-8?B?U1NFQUZFL3Z5OFQ1TzlQTTRnU0UwR1l5c2tEcWowN1ZITXE3clEvcTB0M2RZ?=
 =?utf-8?B?ait1VUJQT29SNkhwSFhtcWZTZ3FpWVZBaE1Zby8xNkcyTVQ2dnFNWTdpbm44?=
 =?utf-8?B?R3ZUMGtXVGlVdmlXTnJ0N0hybXdjYUprNldrajBlWXM4QjR2RVZaeDNJTEVv?=
 =?utf-8?B?QnhlY2hOdlVkMDhEMVhMVWxmQ3kvMEMwTTd5VGNOSkZkVENITXdXOHUxOFkz?=
 =?utf-8?B?SlVhTDhHdmFJYlJtSy9ZaVBFMmQ5cVVUaUZ6WW5rZmhWUWdkeVl5UUhlVkZv?=
 =?utf-8?B?Z1F0Y0ZWeXBESVBhTEh5U2NmejUzV2Q4RzJKTnJNVk4yUXVYT25sOHRxUXpL?=
 =?utf-8?B?d3V5N0gvRVJNcUpQZXZsemdmTGJuand1UjRPVng2SWRMNzdibWF1SjhRaWpX?=
 =?utf-8?B?Qi92bXNqQndQMTBLUncxM2VDMWw1S3JHZFV2MUFLMUZWU2pnTm5wTFM5MXNN?=
 =?utf-8?B?aFVkcnorTGgxNkdFYjczSCtkRnNNZ3p0Ukh2T0RJUGtySWgvajVBaXQvTG9a?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69A1A1E26A357F4B964DE5EAF588B413@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?cytKU2dDR2JtR0pYc3BVOVl5MlFQVWV0QWxVdyt4TERoV0gxb3RKdDZpSFlG?=
 =?utf-8?B?bjFkcjM5V1pMZEJkK3pMUk90eEY3cmFaUTlObUg2alNZbXJlaHZqamNOck9l?=
 =?utf-8?B?ZXp6MHZaVHpnNFhzbzJnQUNoM3RvSGFzYWdabWFXV2xLTzVaRC9GTnpZVVdX?=
 =?utf-8?B?OGl3S3NYVkZwWC9pRjVEQWRsNnVscTU4S3Q5SEJ2bHJMazRvUVlPTFFvbUc5?=
 =?utf-8?B?Z0RxMkR4cXY0aWYrb0lIbjY2ckNxcVIxWVFwdHJyM09iYUJCSU5rdFVUNS9t?=
 =?utf-8?B?VEtCcVFRK2hGT0d0UWUwT3NYQU1Xdzk3bU10WTZ1dXBTYUtnOUM5RDhkYjZn?=
 =?utf-8?B?LzhPRURNenBBekxQblB3RlJoandHOGprOG9wa1lIR09GME1XWHdEVmtDT0pl?=
 =?utf-8?B?Ry8rVWcrUS9ydEg0WSttcU04QXVFVmNzQ3YwMUJSVmdXS3JIKzVscFdrV3Q1?=
 =?utf-8?B?NWw3TFZ3VnpLWkpIQSsrSXdnUWMwbC9HUnlrdGRoRkRqUk5MNmdxNkVibEty?=
 =?utf-8?B?L1ZHSC91R3RDM0FxWGR2K3N4K3lMejRYZkV0aWdMZzNKbkJDWmNkS25hZ1J6?=
 =?utf-8?B?Q3lHdFR0VjNGTlJERUZnVHBZeUk4VnI1aXdteVFGdEgzbUNLN1JVZ1hNWVd1?=
 =?utf-8?B?QXhKUFRHU1lvWUJFejFaY2d6MFV1SDJNVlM4KytyZnpweFY3THo4b1FJMDl5?=
 =?utf-8?B?ZFRMekZaeHJzMG03OWVFelc0dTNRMWZOeDVDTVVMVFlhZmdnaFd5cFpMVEps?=
 =?utf-8?B?K3JMVGpsQlNyVlVweWI1N2xqMk5vaWdYbkY2WlFQZXNGTVRVaWh6K25OWUpS?=
 =?utf-8?B?SVZhM0dzYXRlZXpja2pMdUhxTUUvZG9pWEgyYTd0dVNJQTREbU9pNUo1ODJv?=
 =?utf-8?B?dk1rbEZVTWlidlZtSUV5NWZEVXBWU0tpKzdrbGN3eWt5OThLdk9EVTBzeGRs?=
 =?utf-8?B?K1F6KzU2Ums1YlJ4eGlldWIyaCtNMzNmbnF3WnVFZ3MxTjNCYkZSUzV6TmxI?=
 =?utf-8?B?bnBZRDBEUEg3eHp6ZnNWaHp6ZDNjMlVzdlJsUFJRQ01GTTMramt4b3NMSDhh?=
 =?utf-8?B?VnNKTFNYSTl3YXZiYUtWbWJUaFBnZnN2RTRobnJ1N1ZwT3BmenNoR2kzVnoy?=
 =?utf-8?B?ekVNcy83YjVqM0ZMelNHeHZmWml6TnBrUGJPOUdkU0lDdFYxaDFIV3ZLZnJE?=
 =?utf-8?B?dEVGU0ROWUoyWjQwbUVnZEExOTNvaGNiKzExQnZqNSt3OE1wT1pvWlRTV0xC?=
 =?utf-8?B?bjg2L0RhQXFSWHd2REdHODhjcWtyU0VzdTJTci9OdWozQWVhWmxpcnlkVUsr?=
 =?utf-8?B?d3hzbkMreWtXRVhkZ1QvTmFoTFQ1NDhoVmc2V09EUVE0NkxxQ3M5QUJjWXlP?=
 =?utf-8?B?ZDBPeGVDbVdGaWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cfa01f-dc08-4cda-0037-08dbe934606c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2023 19:18:56.7900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U2OScV+xYzC4B8k4oeVh52UAmeGKNGd9BZKyU0ZLsoCnbzxEFWbVvGW3fYf++uPlzFofk4I+rV9hhR08beTnFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_18,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=796 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311190148
X-Proofpoint-GUID: aFYRRPYOL5CrRtKbEpdiH8vifNonQr7W
X-Proofpoint-ORIG-GUID: aFYRRPYOL5CrRtKbEpdiH8vifNonQr7W

DQo+IE9uIE5vdiAxOCwgMjAyMywgYXQgNjozNuKAr1BNLCBBbCBWaXJvIDx2aXJvQHplbml2Lmxp
bnV4Lm9yZy51az4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIE5vdiAxOCwgMjAyMyBhdCAwNToxMToz
OVBNIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gDQo+PiBXZSBkb24ndCBob2xkIGZfcG9z
X2xvY2sgaW4gb2Zmc2V0X2Rpcl9sbHNlZWsoKSwgdGhvdWdoLg0KPiANCj4gV2UnZCBiZXR0ZXIu
Li4gIFdoaWNoIGNhbGwgY2hhaW4gbGVhZHMgdG8gaXQgd2l0aG91dCAtPmZfcG9zX2xvY2s/DQoN
CkkgYmFzZWQgdGhhdCBjb21tZW50IG9uIGNvZGUgYXVkaXQuIEl0IGRvZXMgbm90IGFwcGVhciB0
byBiZQ0Kb2J2aW91c2x5IGhlbGQgaW4gdGhpcyBjb2RlIHBhdGggb24gZmlyc3QgKG9yIHNlY29u
ZCkgcmVhZGluZy4NCg0KSG93ZXZlciwgbGV0IG1lIGxvb2sgYWdhaW4sIGFuZCB0ZXN0IHdpdGgg
bG9ja2RlcF9hc3NlcnQoKSB0bw0KY29uZmlybS4NCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

