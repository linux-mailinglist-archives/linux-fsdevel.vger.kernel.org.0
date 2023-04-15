Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8787B6E325B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 18:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDOQTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 12:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOQTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:19:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92415B0;
        Sat, 15 Apr 2023 09:19:38 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33FCGrDK016208;
        Sat, 15 Apr 2023 16:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Alp4Aiq23FTrmFReBCvoiQC1Wp0oYDDP5Wti6CbLZN4=;
 b=u5+p1XYfeyO4Kr8D7vboHsb29MiI9yHV3mM3Xa1bHaDKkdS6keF+jM/wlTO9ZTMG4nHs
 kzcyIAA8cLK5emLWtV5t68KRho6/Xn0cWTJX25n8ap6XKwri0umI5RMU+TAKQ4ESWaVA
 w9gcKK4YWZo9OCO8mDC9+aFgevVH0lJHaWkmMdA1e3mCYzzisg/9fuGuBQdaJ3ajyACe
 AYKbM3YIv5qAKvaKCYk8QGkcVjuvrbOH7Qj8miOby5qYtJTrHR6L2j0+B5Vtzb6RYCMB
 KA6wXDgcN8BMBkgTF+0vwW84ESZuwPSyhZpk8pYQjnZbnZmlG3sciu7wL0HmJ32Rg2qg 5Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjq40n46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 16:19:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33FCdDXT027731;
        Sat, 15 Apr 2023 16:19:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc8nfr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Apr 2023 16:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHs6M5/1jJNeWSSie27YIRW8LukM/IEZNrhd0gXZNxhGT7w4AcZSyB7GkGGkqU0f9E0nMqIe2Z1ksWi1rm7kV33t0kHoyf6pEpypE9n4ue0HsYFxzfdf+cLpTvYg4BBeuh7MYwUKBEi98w5VMH/5Va0UcD0Y9/PxBk8PbVuznvGmg2tJQHUT0CG/O2oL67INwgq+ePWT2NXmB67XXfu5j5bsSMAtKX3BMjRCSKepxrS3h/rDJ2cu1gxyBCUAb6uET97H19AWCYImDNK7JDMg6ePv4rKmRxbdT1AWvx6pMqonDIcoKBT80vT3oX848aQgaQc2L2cOC6HYsJsAg5REFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Alp4Aiq23FTrmFReBCvoiQC1Wp0oYDDP5Wti6CbLZN4=;
 b=WxZ7avMosLLBB3bz7ngb4bAAZd8WixTUGWoGT1USUNXgXKfjXnbY/CiBMQ8J+IVGJsQnYKZZriwDNrarthg3xwGUfuZo/F8BH+bXqtHIVcMQ6ToYMx5NsW5Ch8EvrkWYGfLR86zbnlg+2eXhUSRp+EymNwJAbaKuTMJ414PVFe6+amRH6939yYu7ObZvXxkw05TyIFMyE5vqBwsI/PrlRknnQiJp7uqjLeJQ86RJFTslnzpO55X2qy3IRa9CtBU94tIjnh9Pd93ELwCodF5AF3fBy14rgfd3/ml5X7ADEG86bMY3zOYIf/Sp70X/RJ/+HcDwx1YHjDtrllZKSyceIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Alp4Aiq23FTrmFReBCvoiQC1Wp0oYDDP5Wti6CbLZN4=;
 b=WK6NGdwXaqyAq76nFn4ZJ5r8uKzbB+nksvxZ24/Tr45UfiZjgNayTr81wFwfuzRH7HFXrf2IAq7e19iazv9NlzyFtJieBsoHcbA9pdOCVNg8r5BRV0luzoECqclc6oBDjIDiT2aboneP0fwPCPI3IOj6dx7YqiUldDzPi695cgM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6225.namprd10.prod.outlook.com (2603:10b6:510:1f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sat, 15 Apr
 2023 16:19:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Sat, 15 Apr 2023
 16:19:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC PATCH 0/3][RESEND] opportunistic high-res file timestamps
Thread-Topic: [RFC PATCH 0/3][RESEND] opportunistic high-res file timestamps
Thread-Index: AQHZb7YJLa/Gf1rRd0y+RkSOc848yA==
Date:   Sat, 15 Apr 2023 16:19:22 +0000
Message-ID: <5663E686-5158-425F-9149-9C7071423048@oracle.com>
References: <20230411143702.64495-1-jlayton@kernel.org>
 <CAOQ4uxi9rz1GFP+jMJm482axyAPtAcB+jnZ5jCR++EYKA_iRpw@mail.gmail.com>
In-Reply-To: <CAOQ4uxi9rz1GFP+jMJm482axyAPtAcB+jnZ5jCR++EYKA_iRpw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH7PR10MB6225:EE_
x-ms-office365-filtering-correlation-id: 2a72b283-70f2-4ae3-ac03-08db3dcd2c42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ia3R4fPSHL48i1ur8+STcbUlULnrH8VOYvpfIXsosRJEzBwIHcgu+HmmMHPtZ8KqLyYE4/fdY975Qf3H4jEwEnQSLte71aZCS/WY+x5+anymp71fSWfNGgveLIPEYNRMxIJJX/0yfxWv8tXvvjg/BpZPiRIeisq9qzdFxEf+UInfk2Rmnw4IG2so6h3Hb8eMSIZDo5fNRH+aJiHTb3UwBl2yX+URUc9UtJWFRG9+HX/PRpYFKfWzbRfWNWqKX188rdSAQqBPmJzfp4jhLn8lks3sE7XBwhhxk0N7kDetI700hvaceuY6IiUv5ysduF+AamCdwN9uDXLq7qYH9NknASEEfy9NDfsFtMBf1sbqo3EZtrwJD2LezdicSL+CQCR0NeVtF6TinlprJ8CPo7khYjcrnzDKbxDoesYt+C6DPlFf0zcaYRvX+Rkm8DePZrdElDWhdNE0t+sk0N72bbLqP43/R4DbQyzm4pY1pCrss666QIx8yOO+mYileMTuDZIkjOXnzNC1xlbJoFJx5B843LWzRK7b19BSDUvLolL9QJGtKLzSK9amcU7uI84djk1wTel/OHbfS2sldhXOrveFDP7/Ps3gQMLrAGlp5wN82bOiiPG5CaZFErhwBvcMGCl9XT+7Bgw6/EB1bjfAOby1xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(71200400001)(33656002)(5660300002)(122000001)(36756003)(2906002)(7416002)(38100700002)(316002)(8676002)(38070700005)(86362001)(8936002)(66446008)(66946007)(66556008)(64756008)(66476007)(6916009)(41300700001)(91956017)(83380400001)(2616005)(54906003)(6506007)(6512007)(26005)(478600001)(76116006)(53546011)(186003)(6486002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVg3cG5UUzYzK09qa3lPeGZ1RVU3dkZQbXRMcTk1ZFJJL2gzdkJYN0hBNjRn?=
 =?utf-8?B?V2wxNld0cFhzd1VMZmdlNXBQOGQ1TEhLSU0weU5wVFpqSGZYWFc2K1lUK0d3?=
 =?utf-8?B?TVFxcnF2TVFYUEhkTlk1UU93NEd5b2pkTUtLaTgvamlWRXBnNFJOQXNQQ3Vr?=
 =?utf-8?B?ckRENFJmaUluekpOZXhzaFlXK0VSTC9wb0c1cGlmQ2Q1VWVGTnk2SHJ0NW1S?=
 =?utf-8?B?TkJ0NTdvS2Ewa2Q3cDQrc0hBWERzb3NtaEQzbjYrYmtCYmV2a09WWDVld2F0?=
 =?utf-8?B?WURtTUtJN0lUMWRUWFVBRXd1b2dvQWZ6R0ZmNHdsOHNSWmtMWDFWQlFuY3R0?=
 =?utf-8?B?bEl1S2d6ZzllTmIvd3huY1c3bGlKdzhiRnhXUE9mcnRxaUxnRkxJS2ZJblYy?=
 =?utf-8?B?Si80OEVNNHlkcjZoMG0zZG1jL1hXV0xFQVRJR3ZTQWpGejFiZUZRM092VFJN?=
 =?utf-8?B?WXZ4ellPeDhMVG1HSzlEMElKUTZ1VHlxUmhPRzBCRnJ0KzZiT0I4cU8wRXdQ?=
 =?utf-8?B?eWZ3ZjVEN2s0N2RIazd0bG1pMXloekRrTzliN0dhRnJXMVFTWmtoT1BZMnQr?=
 =?utf-8?B?T0U5MkRBUzFnbklKZDRVdWs0SlhpTDh5eDFMMGg1amRZTWFDdkJQS1gvbmRi?=
 =?utf-8?B?VE5Idy9hMlpSS0lrYUxSUkozSzdRcGhoenVGR1c1WTNxS29PcnFVM3pQMzJo?=
 =?utf-8?B?cHNqL0plNC9IaWlJY1NFUEJqVUtzSTBNeSszcVVIT20yTUhEa0pOQXh0SkZ6?=
 =?utf-8?B?QU5RS21LbndrOWFzM3VmaXp2d1lrbzBiVjVZTUNqV3dseit3bFdXTDdTYkd5?=
 =?utf-8?B?b1V2VDE0ZHRnSk9NOHpDS1BIZ1pDOE0yUVgyd3U0enM5RjY3ZWdNK2RQdGlS?=
 =?utf-8?B?TzlqZ3E2QlZOdWt1NkZBR2Q4MytIYkR4bllxU25RcDVsNVZtUkdidksrT1M5?=
 =?utf-8?B?YXh5bVBBNm1QUUhEMmE4YSs2bnZLVVNRR00xS1FrVy9MQVdYWTFZRUZ2ZFdS?=
 =?utf-8?B?dGJuNXdIRW1WVHFhemNnYTJLY1BLYURvQjFSNnJQMEYvQ0JXZjZuYU93c3lV?=
 =?utf-8?B?dCsrL3p5TU5Kd2JWT2dOV0dQYmhPMnl0ME9GemlBUFY4dzVqQTRkYk91aisx?=
 =?utf-8?B?VmczamQxOHJDcXVBMzY4akl6dWdYS2ZCOTlFMmNOVDNibm1mdDBuWFl6YUNN?=
 =?utf-8?B?cTBnSVlDcFdFUDNjQVBrN3RucmtNOUJyenhOUEpPaWtiS28zQnE1YWR6bXZL?=
 =?utf-8?B?cHF4RE1FVnpTTW9UbFRaemdSWmJHbTd6czdCR2syQWMzRStRb2d5UHhZcDJ1?=
 =?utf-8?B?SXpnM0lsTnV1YWdDT2NUV21ObGZFUkZEc01ZZjNyUHVYYUswNXV3UjdFay9G?=
 =?utf-8?B?YlA0U1BGNGdRSzR1bVVNeTNDLzdKQnhyTWV2ZzdURnFBMmVwYUkxanpCQmVL?=
 =?utf-8?B?QXpzUW14NjloUDVLZ2pUald6OG5weXJwUUQxS2RKR3E5MFZ0NklWTmQ1RjQ2?=
 =?utf-8?B?SkZBMlJ1MDh4czJYNEhnVmQxMmVWbHpXQTZYNHZiVjZrbXBNVE85Z2hIODVj?=
 =?utf-8?B?YllzVHJQNGlUUFRQdm9vcnIrMmFiMzBkMWRoWlRqVHJNTjhVU1paZ2ZNY3VJ?=
 =?utf-8?B?RlpYWmthWUlZcGJjL0J5VUt6eE5UV2hYZkhNdXhUck91RTF6WHI5Q3VuRnZZ?=
 =?utf-8?B?QWVMdm9vN29YZE42bEZFTXRQeWM0US9KT0tvbVltc01INkFLSTJieVFxVGsr?=
 =?utf-8?B?VXdQcml5Yzk1U0J3aUlldkw0bitwUVE2dmJhNXNUeWhDSTlnRUlkeGhtTWh1?=
 =?utf-8?B?aDBrRGxTRmczMFJRRGpQaEFTcUJQMy9lekNsT0dWYzRpdituS040aDQ5MTB5?=
 =?utf-8?B?QmlOUlpPaUdZZnZ0aVdOVEZnK0NhaTlvWnB2aG9DcHNGdmN1MEFIRUU0QUgz?=
 =?utf-8?B?alhwdElpaHF1RWlkOG1DRUpCK2xvQ3RnZitEcHNNc2RkR1JqQlhkU2dhdmNE?=
 =?utf-8?B?ZCtQMTZYYUxUallBdi9ZU0ZKM3kzdmwwbXU1UXRadTJaYXRZN29RZHBNKzRX?=
 =?utf-8?B?WVc2bHN5bnpCOVV5OFJRL3lqZmtaSEdueUxuQXlTU3graElVRWwwQWxnUEkw?=
 =?utf-8?B?N25LOEI1VHpWVzR0WHZ3USsvb2pkMkhuYjllMk9wR1Q4TnRPOTBGQktCZkQz?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20680DE33087934EBBEA4A8EA1021B3F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UXRaVysvU1JTZDd1eUIzSjIvTUlZeG9LVlBaR0YwRlo2UU5hcUg1REl6ejJT?=
 =?utf-8?B?SXRyaHYwaUFnV1owQW4vK2doY04weUkwVEZZZnFOOGs2S05ZME44Sy80YTZz?=
 =?utf-8?B?Z1pxWnZKM1h5UWMzdkJtU3JxRG44ZWxGMEZHV2liL3VpZmVYYVNrZnVKZEZs?=
 =?utf-8?B?V2twZHBsR2FUYUZnQzYvV2dTZ0xwMHhxWmFlakhVZFZKeE1LbnhzNTVsN3d3?=
 =?utf-8?B?MXB6dDUrTHNSNktSK0htNWNNWVRRUnlNWktFNERWNUZwZGtBR01NQTZ1WHZR?=
 =?utf-8?B?OXNWRW83cTFXR1VYcERXdnAzYTNYRndYOHNzaDNSZGoySytValYxQi9waEkx?=
 =?utf-8?B?Vi9uT0k2TXhwM1FaOTV5dzVDUEV4MzhvaVBBR1ppcG9xRlo1VjNKclFKNGNS?=
 =?utf-8?B?MTNISWNSTCtSUkdVb01MTEpneXZ4b2hnMktkdU5TUWFHR1pVL0RaNjNNdDRt?=
 =?utf-8?B?YURBU2pLRkFJNW5YRkx2VElwMy82MUFyckQ4ZTQzMUg1MnFNSjcwdWY4RlJp?=
 =?utf-8?B?QnhNWmFDSHZvTWxXMFVSWGt2K3dMbmNxbkF3Vk5WQWZlektwa3B6MEF6ZmR1?=
 =?utf-8?B?ZWZodFoyTGVWU0FKMGJPaGlWOXdZTXNDbXkzM1l0WEpUOUh6aWRWZU9pSDIw?=
 =?utf-8?B?MlpnMXZaZ21lNy9JZXJNd1JhNUtUOFh5VUZ6TktKdjNNNmhGbTI1dlh0VTFl?=
 =?utf-8?B?alI5TWhlSFdtUW4ycURUbVAwUUU4ZWo3TXdYaDQwM0dGdGZhdXg4NTNrVE5Q?=
 =?utf-8?B?NktncDZFcHljclRJMEh2WC9PTTRSS2xBcnVhN0lUTnYrV0ZQYThoV2lCMUhv?=
 =?utf-8?B?WTc1MHo5U1pZMytVYUROTnloZW5LSFRoZ3Rnd3o0eERpWUMrMXF4SE5nT05V?=
 =?utf-8?B?VVhnTEsrMVNiSE5yY2haRUQxRW5UdGlxR2syNTNiK0VUdzB0dUZoRC8waVZN?=
 =?utf-8?B?SnZZU05DaHZBajAwZWIwMUFVN3VtWU9Cb3gzcnpjeXU3L3Q0OXQyL2FSSDdI?=
 =?utf-8?B?M2orRGdQbGdzN2F3SHJIZzVDaGNHWGNWL3JrOGNWVkxjWkZlR1VGRllrL3Js?=
 =?utf-8?B?S1ZhOW1lc3V0ZEtxS21HNlZ3VktZbGlleG9Mbjd3aFB5WUJPVFRIVTJ1Qmkr?=
 =?utf-8?B?YWdUeW9ucEIzTTVFWU9hN3Y3bVl2Q3lpRHBBOU1pdXRiTzk4NEFERUxjNnRV?=
 =?utf-8?B?emR5ckpEcGJZRHlZeXZIVndWN1g4ZHRyWlRZekpRNC9hNTIxSGNpOTZlSGxh?=
 =?utf-8?B?RDJaSzYxd3JLM3A5YWtMOUs3WVI1dVQzUkpXSnQ0cGg5SDhIOU9mUjd4b2Rx?=
 =?utf-8?B?L1BvaENGbjc3WlJqY1lEZ2NwYzZkWVNkL0N3dlplR01EMGxGL3VhbHQ3a1ow?=
 =?utf-8?B?NVFRa1BadlNSMSs0K2NqTll5S1RpTlBLOFFWRGhYRFFlTC83SjZ0WldMY1gy?=
 =?utf-8?Q?jbjcCpKe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a72b283-70f2-4ae3-ac03-08db3dcd2c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2023 16:19:22.2816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LO+mTKvYLgP+VDrfbeFwhLtxpkgWI8H7Ie5hTBWq/aZtuiuw7aa/DnU9jdd99L88o9J3mZUK6miASFJt+K8NJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_07,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304150151
X-Proofpoint-GUID: bYWh0p32B7Ef2-U_sQEkIhJYKCzMOugZ
X-Proofpoint-ORIG-GUID: bYWh0p32B7Ef2-U_sQEkIhJYKCzMOugZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gQXByIDE1LCAyMDIzLCBhdCA3OjM1IEFNLCBBbWlyIEdvbGRzdGVpbiA8YW1pcjcz
aWxAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgQXByIDExLCAyMDIzIGF0IDU6Mzji
gK9QTSBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPiB3cm90ZToNCj4+IA0KPj4gKEFw
b2xvZ2llcyBmb3IgdGhlIHJlc2VuZCwgYnV0IEkgZGlkbid0IHNlbmQgdGhpcyB3aXRoIGEgd2lk
ZSBlbm91Z2gNCj4+IGRpc3RyaWJ1dGlvbiBsaXN0IG9yaWdpbmFsbHkpLg0KPj4gDQo+PiBBIGZl
dyB3ZWVrcyBhZ28sIGR1cmluZyBvbmUgb2YgdGhlIGRpc2N1c3Npb25zIGFyb3VuZCBpX3ZlcnNp
b24sIERhdmUNCj4+IENoaW5uZXIgd3JvdGUgdGhpczoNCj4+IA0KPj4gIllvdSd2ZSBtaXNzZWQg
dGhlIHBhcnQgd2hlcmUgSSBzdWdnZXN0ZWQgbGlmdGluZyB0aGUgIm5mc2Qgc2FtcGxlZA0KPj4g
aV92ZXJzaW9uIiBzdGF0ZSBpbnRvIGFuIGlub2RlIHN0YXRlIGZsYWcgcmF0aGVyIHRoYW4gaGlk
aW5nIGl0IGluDQo+PiB0aGUgaV92ZXJzaW9uIGZpZWxkLiBBdCB0aGF0IHBvaW50LCB3ZSBjb3Vs
ZCBvcHRpbWlzZSBhd2F5IHRoZQ0KPj4gc2Vjb25kYXJ5IGN0aW1lIHVwZGF0ZXMganVzdCBsaWtl
IHlvdSBhcmUgcHJvcG9zaW5nIHdlIGRvIHdpdGggdGhlDQo+PiBpX3ZlcnNpb24gdXBkYXRlcy4g
IEZ1cnRoZXIsIHdlIGNvdWxkIGFsc28gdXNlIHRoYXQgc3RhdGUgaXQgdG8NCj4+IGRlY2lkZSB3
aGV0aGVyIHdlIG5lZWQgdG8gdXNlIGhpZ2ggcmVzb2x1dGlvbiB0aW1lc3RhbXBzIHdoZW4NCj4+
IHJlY29yZGluZyBjdGltZSB1cGRhdGVzIC0gaWYgdGhlIG5mc2QgaGFzIG5vdCBzYW1wbGVkIHRo
ZQ0KPj4gY3RpbWUvaV92ZXJzaW9uLCB3ZSBkb24ndCBuZWVkIGhpZ2ggcmVzIHRpbWVzdGFtcHMg
dG8gYmUgcmVjb3JkZWQNCj4+IGZvciBjdGltZS4uLi4iDQo+PiANCj4+IFdoaWxlIEkgZG9uJ3Qg
dGhpbmsgd2UgY2FuIHByYWN0aWNhbGx5IG9wdGltaXplIGF3YXkgY3RpbWUgdXBkYXRlcw0KPj4g
bGlrZSB3ZSBkbyB3aXRoIGlfdmVyc2lvbiwgSSBkbyBsaWtlIHRoZSBpZGVhIG9mIHVzaW5nIHRo
aXMgc2NoZW1lIHRvDQo+PiBpbmRpY2F0ZSB3aGVuIHdlIG5lZWQgdG8gdXNlIGEgaGlnaC1yZXMg
dGltZXN0YW1wLg0KPj4gDQo+PiBUaGlzIHBhdGNoc2V0IGlzIGEgZmlyc3Qgc3RhYiBhdCBhIHNj
aGVtZSB0byBkbyB0aGlzLiBJdCBkZWNsYXJlcyBhIG5ldw0KPj4gaV9zdGF0ZSBmbGFnIGZvciB0
aGlzIHB1cnBvc2UgYW5kIGFkZHMgdHdvIG5ldyB2ZnMtbGF5ZXIgZnVuY3Rpb25zIHRvDQo+PiBp
bXBsZW1lbnQgY29uZGl0aW9uYWwgaGlnaC1yZXMgdGltZXN0YW1wIGZldGNoaW5nLiBJdCB0aGVu
IGNvbnZlcnRzIGJvdGgNCj4+IHRtcGZzIGFuZCB4ZnMgdG8gdXNlIGl0Lg0KPj4gDQo+PiBUaGlz
IHNlZW1zIHRvIGJlaGF2ZSBmaW5lIHVuZGVyIHhmc3Rlc3RzLCBidXQgSSBoYXZlbid0IHlldCBk
b25lDQo+PiBhbnkgcGVyZm9ybWFuY2UgdGVzdGluZyB3aXRoIGl0LiBJIHdvdWxkbid0IGV4cGVj
dCBpdCB0byBjcmVhdGUgaHVnZQ0KPj4gcmVncmVzc2lvbnMgdGhvdWdoIHNpbmNlIHdlJ3JlIG9u
bHkgZ3JhYmJpbmcgaGlnaCByZXMgdGltZXN0YW1wcyBhZnRlcg0KPj4gZWFjaCBxdWVyeS4NCj4+
IA0KPj4gSSBsaWtlIHRoaXMgc2NoZW1lIGJlY2F1c2Ugd2UgY2FuIHBvdGVudGlhbGx5IGNvbnZl
cnQgYW55IGZpbGVzeXN0ZW0gdG8NCj4+IHVzZSBpdC4gTm8gc3BlY2lhbCBzdG9yYWdlIHJlcXVp
cmVtZW50cyBsaWtlIHdpdGggaV92ZXJzaW9uIGZpZWxkLiAgSQ0KPj4gdGhpbmsgaXQnZCBwb3Rl
bnRpYWxseSBpbXByb3ZlIE5GUyBjYWNoZSBjb2hlcmVuY3kgd2l0aCBhIHdob2xlIHN3YXRoIG9m
DQo+PiBleHBvcnRhYmxlIGZpbGVzeXN0ZW1zLCBhbmQgaGVscHMgb3V0IE5GU3YzIHRvby4NCj4+
IA0KPj4gVGhpcyBpcyByZWFsbHkganVzdCBhIHByb29mLW9mLWNvbmNlcHQuIFRoZXJlIGFyZSBh
IG51bWJlciBvZiB0aGluZ3Mgd2UNCj4+IGNvdWxkIGNoYW5nZToNCj4+IA0KPj4gMS8gV2UgY291
bGQgdXNlIHRoZSB0b3AgYml0IGluIHRoZSB0dl9zZWMgZmllbGQgYXMgdGhlIGZsYWcuIFRoYXQn
ZCBnaXZlDQo+PiAgIHVzIGRpZmZlcmVudCBmbGFncyBmb3IgY3RpbWUgYW5kIG10aW1lLiBXZSBh
bHNvIHdvdWxkbid0IG5lZWQgdG8gdXNlDQo+PiAgIGEgc3BpbmxvY2suDQo+PiANCj4+IDIvIFdl
IGNvdWxkIHByb2JhYmx5IG9wdGltaXplIGF3YXkgdGhlIGhpZ2gtcmVzIHRpbWVzdGFtcCBmZXRj
aCBpbiBtb3JlDQo+PiAgIGNhc2VzLiBCYXNpY2FsbHksIGFsd2F5cyBkbyBhIGNvYXJzZS1ncmFp
bmVkIHRzIGZldGNoIGFuZCBvbmx5IGZldGNoDQo+PiAgIHRoZSBoaWdoLXJlcyB0cyB3aGVuIHRo
ZSBRVUVSSUVEIGZsYWcgaXMgc2V0IGFuZCB0aGUgZXhpc3RpbmcgdGltZQ0KPj4gICBoYXNuJ3Qg
Y2hhbmdlZC4NCj4+IA0KPj4gSWYgdGhpcyBhcHByb2FjaCBsb29rcyByZWFzb25hYmxlLCBJJ2xs
IHBsYW4gdG8gc3RhcnQgd29ya2luZyBvbg0KPj4gY29udmVydGluZyBtb3JlIGZpbGVzeXN0ZW1z
Lg0KPj4gDQo+PiBPbmUgdGhpbmcgSSdtIG5vdCBjbGVhciBvbiBpcyBob3cgd2lkZWx5IGF2YWls
YWJsZSBoaWdoIHJlcyB0aW1lc3RhbXBzDQo+PiBhcmUuIElzIHRoaXMgc29tZXRoaW5nIHdlIG5l
ZWQgdG8gZ2F0ZSBvbiBwYXJ0aWN1bGFyIENPTkZJR18qIG9wdGlvbnM/DQo+PiANCj4+IFRob3Vn
aHRzPw0KPiANCj4gSmVmZiwNCj4gDQo+IENvbnNpZGVyaW5nIHRoYXQgdGhpcyBwcm9wb3NhbCBp
cyBwcmV0dHkgdW5jb250cm92ZXJzaWFsLA0KPiBkbyB5b3Ugc3RpbGwgd2FudCB0byBkaXNjdXNz
L2xlYWQgYSBzZXNzaW9uIG9uIGlfdmVyc2lvbiBjaGFuZ2VzIGluIExTRi9NTT8NCj4gDQo+IEkg
bm90aWNlZCB0aGF0IENodWNrIGxpc3RlZCAidGltZXNwYW10IHJlc29sdXRpb24gYW5kIGlfdmVy
c2lvbiIgYXMgcGFydA0KPiBvZiBoaXMgTkZTRCBCb0YgdG9waWMgcHJvcG9zYWwgWzFdLCBidXQg
SSBkbyBub3QgdGhpbmsgYWxsIG9mIHRoZXNlIHRvcGljcw0KPiBjYW4gZml0IGluIG9uZSAzMCBt
aW51dGUgc2Vzc2lvbi4NCg0KVGhhdCdzIGZhaXIuDQoNCklmIGx1bXBpbmcgdGhlc2UgdG9waWNz
IHRvZ2V0aGVyIGRvZXNuJ3Qgc2VlbSBzZW5zaWJsZSwNCkknbSBoYXBweSB0byBjb25zaWRlciBz
cGxpdHRpbmcgb2ZmIHRoZSBtYWpvciB0b3BpY3MsDQphbmQgdGhlbiBpbmNsdWRpbmcgdGhlIHJl
bWFpbmluZyBpbiBhIGdlbmVyaWMgbmV0d29yaw0KZmlsZXN5c3RlbSBzZXNzaW9uIG9yIHJlbGVn
YXRpbmcgdGhlbSB0byB0aGUgaGFsbHdheQ0KdHJhY2suDQoNCkkgY2FuIHN1Z2dlc3Qgc29tZXRo
aW5nIG1vcmUgc3BlY2lmaWMgaW4gdGhlIExTRiBUT1BJQw0KdGhyZWFkLg0KDQoNCi0tDQpDaHVj
ayBMZXZlcg0KDQoNCg==
