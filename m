Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A706F4E39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 02:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjECAoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 20:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECAoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 20:44:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979EA2D5F
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 17:44:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342INkBl005218;
        Wed, 3 May 2023 00:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2rDcg6sOzclcBUv65EbHWtF8aEpGQ7fariFf4Z84JCM=;
 b=idE4WQ8V7hH6beVrIKWIyuwJcjJfEW6wlLoTUMOeFOP8sVyGCj8N4VorhZaug00Ws8ys
 8c5/R2HIpGe4+TLF+SDnuBp9d5tZ0b/nSlptFTCcDKQyRy2d9mSGfiF5jEJOPcOvTdt2
 JYi97MlLrLnMZQZKNFCGYEf+hG5Lv7ImaKPIzVWpJ+X27Fw/OUOVE2BJOvLO+c93Hsjf
 JUdVQHAGq61yDhJxx8jmMBQzOuMevO6ChDem3nSz/82+GBGzlkmwLLLQjZQ0zNm9mFe2
 6fPjFAvfyMqLP+kNHQ24PhRsU6/e/EWXcp0EOXjNmt37FpjwBnx1RU5mIQ6oaZCbNwNX ZQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sne644c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 00:43:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3430AsK3020794;
        Wed, 3 May 2023 00:43:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp6fj80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 00:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIfx4luU0uB1WtZfqS2F9OUDAH5+82bU3cITEJ475h4iylLn++5mdgrlGF/QcytVAcbB9II6PyoHQYmB0FCStPaFo/YdKcjHVVojShPXcB72xh1UZNsZ+HMGVHzG6UnJBSmBKnidbLQ+tnDlVRKzJNtzBD5HnfZmvzkJKIS55vNMr7SqWZzt8Y5yspc0C/UTGAbzRAZILNmRD5C48JEBNIhWh4REud/pYyoyEoZSP27KMtGaD7gNzA9904w4duh34SAUIYN8R3GFlUNX01UeXSrafHVLF1NTon4UJ1ZJBfDvsrdyfk0XGZpwxE5yf9n/pUVnxuagYHidlD5hZh0t3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rDcg6sOzclcBUv65EbHWtF8aEpGQ7fariFf4Z84JCM=;
 b=kjXCLL3vRCvIaBFlWAr3pneGwXXj/HKTuyVtnTSQntx2rBbDSpN5pgeK2laPnyLXa9p2g09vmaoYULTS96DuhkcQ6nKHtWdhOe+XaBs3ZCYnXBtC6tZAVh2WtRGDTkhxpTxqVXK+isg6QNuR112/gzJT6pqPkp3obRg62PW0dB43onuhSZx2n8Nwjt5BpQTqLKMXhwUGnaah09YSkJvWUlThQv1YUJCaBTPkW1YK1McCcULhE2T8c1fIr4Sbm4j2mCzC9ZELPjOYLd0NaCHkNtwG0Qy9Vt4nSd13JJHfWKh9cPVb8wNiWCMXB57nZAWPZTeeYbKqBJ8SqgRuu/aong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rDcg6sOzclcBUv65EbHWtF8aEpGQ7fariFf4Z84JCM=;
 b=mTIUjx4oCP6uR4SjzmY2qpnrBDh7WbQT4w2w8CUsBZiwn8VDMUnHllHZAptEQ8+sFgZnZNQqBvtuDN6GUjCi5uPlv3CYfchiMLfcwCt9ipK6LXNxv1k8Q65v6FS73Z7kfl85MJBTOI2KN06Bkd9PBPpTowptYpxXzSuVUY6gsRs=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB6981.namprd10.prod.outlook.com (2603:10b6:510:282::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 00:43:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 00:43:54 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Chuck Lever <cel@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1] shmem: stable directory cookies
Thread-Topic: [PATCH v1] shmem: stable directory cookies
Thread-Index: AQHZcWIY70gloSR/DE+raKGoXfqrja9HxR8AgAAIvQA=
Date:   Wed, 3 May 2023 00:43:54 +0000
Message-ID: <30E5A657-4005-4126-A962-A8E6D90240AB@oracle.com>
References: <168175931561.2843.16288612382874559384.stgit@manet.1015granger.net>
 <20230502171228.57a906a259172d39542e92fb@linux-foundation.org>
In-Reply-To: <20230502171228.57a906a259172d39542e92fb@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB6981:EE_
x-ms-office365-filtering-correlation-id: 9248566e-94a9-4f13-b39f-08db4b6f791c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sYoDQoKcJs5trWXHBuLJdDJwqCWvEnboXkDjtF73BwZUc4GPETe/TNirv1jPz1lp5dyG8yhy89c4Gf0n4tLE9mBao4Np2nYx7Jg3Oq550J7dhNi6Rdc+Z4WPe/nT0T614kcLFjxbVb1Iphg7CGOFNMS/Y04C5VGSMEsyDkknaPuZQKouUMvhLEbirZZ1vDoae4KvCyzUFNT4XCFV94jgI/mCdnkB/YP/VMcRsqZWPRepiIhl4kchyOQwIxml+4aVm/rEwOI19gdSTYaSRkob8EbGeYKvF0eETnIdbQ2mWFk/ssJ0ztRvBZ7XIpdQ1wsViZeNVc637bjSnmWZIjHWJXUk9yxGts6YXtSILdl5L7kJyV3QI4swHZojY3hT2nNwycKtrBvDs7jA14BoPO4lFixgzPF+Qeg978aVKLW3gKdOHPdA6vdBAzjl7b2fL+/b0ULblJQ6j/weav/UxuP9Q7l4xpyvhKeQnRpS37WDKGeEh+O90G0z8LALCCFgAeRZy7c/cWje5nRSuESFfw605jfVA6A4um56Ar0bhMLu8p5OcXyoAPyFIYmcBUauOOdz8rW5+dOX85VYdrHBCPxriTPjaGmy5Qe9SKNmzKjjq6MBFgFCoiTOj/dCxc4FfUOw4zraF3l0Td1sBAWtVBTn6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(38100700002)(122000001)(478600001)(38070700005)(33656002)(83380400001)(2616005)(36756003)(6506007)(6512007)(26005)(186003)(53546011)(6486002)(71200400001)(86362001)(316002)(4326008)(6916009)(66476007)(66446008)(64756008)(5660300002)(66946007)(76116006)(91956017)(66556008)(41300700001)(2906002)(54906003)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XRo0HNNuHHoZUIbPAuhT+dVuatNo6PFWulOkAzV7Y49bb9I7FQnju5hSU3WV?=
 =?us-ascii?Q?ZpcyPWqOitxdnsGQd+aC9ACCn3et58GhhaUQFLaMBtLF5VFBtI/VBh03Vwof?=
 =?us-ascii?Q?+aWaEsavbdBQan621wWEWmPY7CK5ypIE9ces2rufVe4dUesEcEWSOIVtvDbQ?=
 =?us-ascii?Q?a9Q/7jq18yyQ1arGgdzzRTMu2Ku0NIngL5uczkPwhrHE8Ijr00qHB1a1BHYd?=
 =?us-ascii?Q?eQmKF4vX+dU6y8pLEMUlVTwueFBflsk63QJvq5NNAOJ/EAcbsDNyg9F7sv7p?=
 =?us-ascii?Q?pxTNXJzd522EWk47h8JBJOKvN9BiG3yPfv6cMa/AswspLi8OjqZUX/WHnsRM?=
 =?us-ascii?Q?V5wuD/2rF7OD4kHEXBueaeoDsrGubb0XnVAuZKYnqD5ArUBeYgYN+pfX0D4f?=
 =?us-ascii?Q?rQNiK/O695QxdubaclJh+geTQO6MsirSfHVJLYKB7gxBsI5E3sWNtfNTDq+m?=
 =?us-ascii?Q?CRU9n3W8FWOGfgOZM94OR0rMHUOcBoMtzgjvfnxdJgI6fVXCWYmHHa2tGJ/7?=
 =?us-ascii?Q?peZ7Rcd3f04w7gX3XS8vnFjBjuyou9BRkwjt/dOCpY1fu4UXjzbcW6Tl/UFi?=
 =?us-ascii?Q?VyFoitlPISlQc4y5hGnHXW4MGrDa+Pq5y1aB/gT+iabNTO8r+FJWnTJTDB1z?=
 =?us-ascii?Q?k9fRR1QItizStHQ6m5I47JVLq1rX+1P89vXZ3jmlo2JDTPnEoGR/q5SBIbLZ?=
 =?us-ascii?Q?vuwzYjazZyrdgmyJTpMed+wAO6431H5dAfzV/2zbQ+WXyBIL4NThqoPyRB7z?=
 =?us-ascii?Q?dm0RI4rECdTJ22PH1Ti/T1mjSsn9R7x7Ov/EJEaj2N8rp94v473KXIUpTUdK?=
 =?us-ascii?Q?fI18+caWmz6holbUsLN93VjtHpsv/vButPmuC0D3A41R+TVSM7MNG0MdFVCP?=
 =?us-ascii?Q?ovzitjAHHDo6Ktkakls0G3mG8LHu7Rlj7gSzdCU91OZvItpuXWGKlaGzIsjm?=
 =?us-ascii?Q?sF95fhuCQLGEDYZYU6WkUPBQ8kr2+1oJCpPM3aHCG2ZFGbtMsCqgwPSo+YM4?=
 =?us-ascii?Q?l9oo+KzvPnZrjzveq+cc+zP5iJhKScDzboEsXCNcBiU8jG2vrQzDGUHOrlsF?=
 =?us-ascii?Q?AG7mnA2THWhfTWN2kV0XpYrZzb8KYN5WExGfkeD1wxUdHg/l5B0jr06nQXz/?=
 =?us-ascii?Q?9Lt+FHeP0y5CpYGNZWG/sZ1ZEpsj2+m3Lua04pCYAieA++1n0/SYO4YgZwkh?=
 =?us-ascii?Q?IvZdlv+UCf7N1JEP2lmMKG7vWMncbCGz8xHwJNlKtkSMQVZWPAB2xkO1xyTc?=
 =?us-ascii?Q?FCL1VzZWIJAZ4RIESMQbsTMFpPnEo+FikDEuFg1h2ldK8lj+Isxblh534Aew?=
 =?us-ascii?Q?mGrBY523fPClzQbod3BERxZe+HkSR22XyvbsqEO5S4Ydjt1OJLsVeJt1/hjT?=
 =?us-ascii?Q?ENmQ/fJnZXeGURPK76xjd2VicGivMnATpruETJy0gUWp7OvnG9woTrQPGGNn?=
 =?us-ascii?Q?Pkp5QEpZGxHs8RM7fNWcVgzaTJylP5puqCRRCCRnqsDwm2JdC8kkyplwaITN?=
 =?us-ascii?Q?DW55iTWy/ctE7WsOIlrXrEQcZMegKVwWorSjjH8CjKfnx3LFMPn//YxMw8S8?=
 =?us-ascii?Q?ZFs9BLGO9CexGR6MA/1E+zOJjfI0HOl/wqoM//h/ySnddOuRSA0OLPwTvKgI?=
 =?us-ascii?Q?HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF6BB64DD7EEF3409E468A4724BDB0CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pUZLFw08vW3k8+KQS8tT1MDBflNsdODGeQ5/FPH5PIX8KgcOfAwnp3SHBA+5rkMHGOmx9W0JtNFNmGoFSqHnqaNpZo+SUSUxxvjd3NulK5yRAKouIhFl7955EgvsUurByrzk5X6b/JDdA+Fx3yHlhquGbDj6j23g7us4Nd+zxVVzxm6rsTtXh3PgXtnM2XcTf+aq8PEn0cmfzvrx+PzFcTaRoJSYGYSoZ4YajA9Y3YtMPa+1UxaVZtsUYTdrs9d0TvQ1HkIFTMHfCS+1OvvwubgbGAxO1mkBKxZbzRZsYg+rJJemRb95TkcCiv2JP/eOOyfG/4bnx4/IiISj6I1YbrTbVgIOm0DBBa2rPaKaI1IJ+a4nIaHHDd+LHgMR4Nn41o4aFYWuTy7lGioc+Hef0iNClq2iA5mniVDDVwyNBmpVKH6IjxK1kLuAchvC0ts3N5CB10LCq90S0pDvim5J/sBHKP9uFiWJwAlNrcp6uvz/nW3DyLbyPG919mIYZsB3052dkriHxH8fK6makPR1Hn0r/Ha3ELtjv4HMRqPik8DP1ONz/3gJIM1LFmFT9weaQ3iMVPc5+aSg1LOEkGpcjfEOVquP1ustXlAvIYdKq0eS0/DXe4KBg3xpfS+JbNjoJqdOgQRMkAgt29zHme7pQ/r0mkW6F93fRZpS1BuZsR1nz1l0/Ot1jtbPwC/0drfY6pnxyTMV4R4XA12J67PI9AAuYGJWEJ+bzoK7gk/KZzIJVMND9ielk6b7zxMHAifnCxi5a2p77c7bgxuZ3jLhQ5szMy+TjPs51WlgzVOTXpjaIsp+9kUc8ModGTlZhogSegIjdjdz9776HBiBb8YVWezIrqh06ROa0GOx3ApgVLI6Zk0bYLJURCvLjUwUuxiFB6CrtmM0Q9EuK4ZBrLiTkw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9248566e-94a9-4f13-b39f-08db4b6f791c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 00:43:54.8432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gt45J/KPAqrUkeO9T5eqDw7wPXckZ32Vk0jV2FJT155dqiq4l/OTlfoLQisLBjG/JHmWEB9J4KRNVyDpEbIYQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_14,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030003
X-Proofpoint-GUID: G2ZhHJyJ78jnbOQYbPY8Eqy-JUS8nE5c
X-Proofpoint-ORIG-GUID: G2ZhHJyJ78jnbOQYbPY8Eqy-JUS8nE5c
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 2, 2023, at 8:12 PM, Andrew Morton <akpm@linux-foundation.org> wro=
te:
>=20
> On Mon, 17 Apr 2023 15:23:10 -0400 Chuck Lever <cel@kernel.org> wrote:
>=20
>> From: Chuck Lever <chuck.lever@oracle.com>
>>=20
>> The current cursor-based directory cookie mechanism doesn't work
>> when a tmpfs filesystem is exported via NFS. This is because NFS
>> clients do not open directories: each READDIR operation has to open
>> the directory on the server, read it, then close it. The cursor
>> state for that directory, being associated strictly with the opened
>> struct file, is then discarded.
>>=20
>> Directory cookies are cached not only by NFS clients, but also by
>> user space libraries on those clients. Essentially there is no way
>> to invalidate those caches when directory offsets have changed on
>> an NFS server after the offset-to-dentry mapping changes.
>>=20
>> The solution we've come up with is to make the directory cookie for
>> each file in a tmpfs filesystem stable for the life of the directory
>> entry it represents.
>>=20
>> Add a per-directory xarray. shmem_readdir() uses this to map each
>> directory offset (an loff_t integer) to the memory address of a
>> struct dentry.
>>=20
>=20
> How have people survived for this long with this problem?

It's less of a problem without NFS in the picture; local
applications can hold the directory open, and that preserves
the seek cursor. But you can still trigger it.

Also, a plurality of applications are well-behaved in this
regard. It's just the more complex and more useful ones
(like git) that seem to trigger issues.

It became less bearable for NFS because of a recent change
on the Linux NFS client to optimize directory read behavior:

85aa8ddc3818 ("NFS: Trigger the "ls -l" readdir heuristic sooner")

Trond argued that tmpfs directory cookie behavior has always
been problematic (eg broken) therefore this commit does not
count as a regression. However, it does make tmpfs exports
less usable, breaking some tests that have always worked.


> It's a lot of new code -

I don't feel that this is a lot of new code:

include/linux/shmem_fs.h |    2=20
mm/shmem.c               |  213 +++++++++++++++++++++++++++++++++++++++++++=
---
2 files changed, 201 insertions(+), 14 deletions(-)

But I agree it might look a little daunting on first review.
I am happy to try to break this single patch up or consider
other approaches.

We could, for instance, tuck a little more of this into
lib/fs. Copying the readdir and directory seeking
implementation from simplefs to tmpfs is one reason
the insertion count is worrisome.


> can we get away with simply disallowing
> exports of tmpfs?

I think the bottom line is that you /can/ trigger this
behavior without NFS, just not as quickly. The threshold
is high enough that most use cases aren't bothered by
this right now.

We'd rather not disallow exporting tmpfs. It's a very
good testing platform for us, and disallowing it would
be a noticeable regression for some folks.


> How can we maintain this?  Is it possible to come up with a test
> harness for inclusion in kernel selftests?

There is very little directory cookie testing that I know of
in the obvious place: fstests. That would be where this stuff
should be unit tested, IMO.


--
Chuck Lever


