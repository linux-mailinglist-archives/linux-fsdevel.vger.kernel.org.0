Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96CF6E7B46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjDSNva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 09:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjDSNv0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:51:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2833146D4;
        Wed, 19 Apr 2023 06:51:24 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JBcCSJ025376;
        Wed, 19 Apr 2023 13:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7PQ2pDCzkh1yTvhwQf+6jcoiLRhBk5ms63cCWgR4EIM=;
 b=QrmC1W76ej4YilXGwnRc8m9APL3oWMTeix4bJlm1qA4h+CntHgq4rh97i19TarzxnQz5
 io7ZjVhyzWikmgkjxT+ufqDWNc9S3g01zHY8f1+QWk3+6cJjj5tLahuM2AUDPFjTMq6C
 HDj4322f+PKPBAbxeV8LDMyNdt6hp/R30PLyzRDWyidVwGRl25cgYTcBx62qMzywWdm7
 VnFs3Cwi+UMqbXYf7uBm2N1aoyaItQ2PCmsgLErpxOJu4x48JPGBdZQTr3WEfol7H8KR
 invFdKizxdE2JryAHqsha6Bcup39H+3xOR8PyKcsbxu/tPpxrFhqIw4ugiBY8kDxMsVy pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykyd0cut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 13:51:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JCDTMQ015747;
        Wed, 19 Apr 2023 13:51:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjccyyyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 13:51:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDFI6P9JUOEFG76L8BBZt34O5egJ16FzrLrVn3N0cZ4X5ulJqAtXsXWwdeEXNYo9Q5IRz8fWlpgEXzyvbx93mj3cafNM/O0SoKwIT7FLmMbxp7CHvYehXVonalpnTfQSQZVrclmlP5/4Gu1sBF7iF5/bhkQ5dxP9tQPkL2FB0KpG34b5kloG5ednLDWWS7PELuWHlc93QdS5Z9UolRjJzRXa94t7oIIivZYhFIsYStL2N3b4Swv/s5dFu/BTlDTUOPe7cw+AZdVc4J757iCVZqgJ8+ptS8uHAT5YVglBXZ5w8pyIYI+36iVvb8GTFcxkP6QiulqQT6FhmYySJJvhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PQ2pDCzkh1yTvhwQf+6jcoiLRhBk5ms63cCWgR4EIM=;
 b=T6DIaTm2wFJ2GJzUewCzm0AzMt7iRG9ugyhcw29kHVaeZy+cO5iSBLQvmkoNAsXHR+jINZQN3w+ClqRRkZ7BDU2zlZURCwLWvNt2NU751D1VEQ+F0J2Rls5BHtrWuyxb8FqytFpy7DmGRkfIvZoMDqFDBmNTuiGpyhOMQqbFwiFZksr75vrminK3K5lZ6QKN9s7HfJRHh8yjahrWmTdKY+WZXZ0/w1jIRnF+92ou1OF5SPG+LZ+zhAHKdLHbXzl7Bvk6I5D/m9IBxHVjdbIlHwnNID/EL5gchmCdxEAppQrvz6bV4SBXa+cKxsMaxfSDROJie2PHMZSyHFN+/jdytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PQ2pDCzkh1yTvhwQf+6jcoiLRhBk5ms63cCWgR4EIM=;
 b=Nhmtl0lv64t5nRgDZwZsqEENTOaHYEUefWcRMiQ1J9lWnwNgvjH078IVcBdfdWHI87upZ59ZPf7bhbt+raDe+/XzvwUEMh7AqLwVLSa5tr80mdSVpWk0lvFI6MLAlNTyhqKTPwoGtcwKzxav7Wq/klWCYnK3NiYAOc/297Wn1vg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4368.namprd10.prod.outlook.com (2603:10b6:208:1d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 13:51:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 13:51:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Frank van der Linden <fllinden@amazon.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Thread-Topic: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Thread-Index: AQHZb4qhR4jn7R6+a0evVV4Y3qmRcq8si0OAgAAQUgCAABjIgIAAToKAgADRqYCAAMVVAIAEEwGA
Date:   Wed, 19 Apr 2023 13:51:12 +0000
Message-ID: <A23409BB-9BA1-44E5-96A8-C080B417CCB5@oracle.com>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
 <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
 <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
 <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
 <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
 <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org>
 <20230416233758.GD447837@dread.disaster.area>
In-Reply-To: <20230416233758.GD447837@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN2PR10MB4368:EE_
x-ms-office365-filtering-correlation-id: 8582868f-145c-4b9c-de7b-08db40dd2325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OjO06h8JGtiT2Wx5iK6QbnyE/tua74hYLKkHMXyS7B3lWH1nF1qa2WIXNeb5wIgCiUOIn3cCjIZr74b8tnAQYlZLGqs4jcVShP5rWWRXRc8k7hT7fXZ7qvGz0C3p87uqfzbE4OoEovj0zxpjhbhIG2mCRXEg2X6F6rOxWdVgsCvxf1CBQcJCq9hCBXmHfytVzQ0gza/oMNgeXqmtHA9RA8c/IORd9AiyXyuwZ/18R4qoKDUprKfIrE12mGBw5K6j/zRSu5Rbn6MneYQRdOh4sguST+S4qZf3X8BrSblZZElbmQZym9ZMv2GN9kYGL1moI8E69G52pDgzYPsNhCRYfYL3aKH8Y7sXkxPYPBEIliEVQe2VC0GS4dWJYDj1LfQ+eCpygM79wvYNOcvbSnCTfudZgWi8jgO3YOv5ANVvgOZCrp3vtqkWZS+n115uuBp6TsUpDRqWgZU2dJnZiGfW6QxEJBubSu0fTjEV9t0j70Pcl2Ibmvo/ebVg5EAhkM1ipWrtQbnocgMUxnSyHKdTchpb0T1YamGn18PEH46Wya0iSRtSP93WrZL00NoAwwkLWdkqsq8nxluATgSOrV77QrNk2qI7Lv85TF3RrVxuePJslG8JM8l50zJSaewxbrKe+q+7zP1JxFhhkA7t+8SvYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(66446008)(316002)(91956017)(66946007)(4326008)(66476007)(64756008)(76116006)(66556008)(6916009)(478600001)(41300700001)(54906003)(8676002)(8936002)(5660300002)(122000001)(38100700002)(186003)(53546011)(83380400001)(2616005)(6486002)(71200400001)(6512007)(6506007)(26005)(86362001)(33656002)(36756003)(38070700005)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q8vVWfUkemkv+HObC0JBRx3eLinY0j0aXPFM7KrlIpZxtuNttuUCbvzY8Q3C?=
 =?us-ascii?Q?pSbuaRb2IwK9wLImNhpEBYwpeWe/iPWDl3vR0YNaKhEWMPpbxS3D/osYHl3I?=
 =?us-ascii?Q?Y1XsyvNACuEcPLuqcDOWg2/kI7k3BRSfzYgAycxnKWlH34D+4kzELX4/WodP?=
 =?us-ascii?Q?7IRLV2Uwi7DvoYsXK7xxCYULq21c0R+MofIqT4RCi+B9rxQb6yCwb1Cqou3Z?=
 =?us-ascii?Q?dwV9vtWl0WcsCYBiTyA6JApOT2+COBxjTuLZ+8tvyVRNF2tJ+Pf5qzVPcqfB?=
 =?us-ascii?Q?OzBIER7J/uMsLOUPYKz28bllzgv+YwFc45IwppHIRpD9tmUWDys5W19ahC3H?=
 =?us-ascii?Q?nNJqPjYIC7hY/8KAcTueuVzmP1lJF/AGPWLlCUIqc2/TkIKVFvuiaczu4BCZ?=
 =?us-ascii?Q?m829Tbv7JSaxPHBM+axyoryVnXBcnyrlOSQExUqK4kwMyPzqase2E2RxfuOx?=
 =?us-ascii?Q?JZHbAItmwxEJRO/+COkJN5KwGQ4yq2HNcVkyBa1BulfiqDEJ2FX0vXgRC612?=
 =?us-ascii?Q?BFE+JLMZ/iN33y9QZxb2TpLE19Sb++sRQlwgfv4pBGu8EQJ4FqfIvDPk0Unm?=
 =?us-ascii?Q?5yeZjyCgwm4uwVLve60J/iuvo3bsWlVOXbbwOgU8utHpCusUjnwcWZ+szAFW?=
 =?us-ascii?Q?mmp36PMsNmQ4IiTA6vZuR1HeWzileMPtlsWj9wEIs5B5UcWrhvpga/aNdfsA?=
 =?us-ascii?Q?B+U0zPSdI95x3kfPmoq6/pS4yDeU0z06LkDcEmE26UQKwIf1kFizPQofMSfj?=
 =?us-ascii?Q?dlwRnzBqSiBoQM7KpzOmew3JMaYIBLtIkWuLbjctE0jNyPK8/LtSdtpBIMgi?=
 =?us-ascii?Q?A47zIdw5lKPdt5TuTfddZecgGwDoSDEsIk7dzoexMXF3bjSESkKC1U46r7Bn?=
 =?us-ascii?Q?YoDiAwRauFoPluIMWr0tNDUdY0DuR7nd6ipJLsaaN76SYOWZLFxYVsXyM+U0?=
 =?us-ascii?Q?jP3Rk/wsgS0XnOQN0rhX615+M+FWptZSD1WW1O69FRPFxlbHXQKRr2htXiz4?=
 =?us-ascii?Q?tiSMTca3hq8Qb13xmBs4wxcZ0wBYi2bbAZxpjwRkxTE+gzDBjsENzP/6tNl+?=
 =?us-ascii?Q?k1yJMf6TU/d0wgWRQc24I0eYHnuAN47HlyiLNiywy9wdemnelIbYKQGABzkw?=
 =?us-ascii?Q?XOoufxyx1+p7OmnmdGo5EUQ2HddE8+VVk+MFzzxLlotvUgDqCl7yRJaty9BL?=
 =?us-ascii?Q?1gEt2pi7iF4noAaifdbOl6f8pL4EaeUZFbpheNt+VGlliZFqGNVFbU54FEF0?=
 =?us-ascii?Q?6gzp0ntkWmF0SdfUOMR83wccQ7BTbC0Kce9XS8dqGEPa7TOesGoSYRMsFJEZ?=
 =?us-ascii?Q?yMPg8b/SHhNQJzNtu8v3aWFDl7+HIue4eHnmXmcXIVVssiLjXjqB5r3T1Nki?=
 =?us-ascii?Q?uehwuQN12LAqFDb+DaFo2PGA0zNiTb2/80Bmaj9z8ZVhTW4a/KjzO26Rokbm?=
 =?us-ascii?Q?ajrnMD0pIT7kPdTHFGM8viDEuOYn5006+D10FeGZwayhpjwib0t5wbG62RlD?=
 =?us-ascii?Q?07y+MEcGckelCmDKQkZsLq3YB/MtqK9HIxpP488eydGvI05N4IQd3RBSkD6B?=
 =?us-ascii?Q?ppTgrlePe7HMbnRsy93fsZmyCKsEuaIfiwI8Ct2UgBMD3iXdC+R5BQJ2iZei?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E6E10D6CAEF844393CEA00765E1AA2C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D3tXUm4PaxDlWuL7w3QiydxPeW6j3DVnP8Ovl+glstRtA0zQnN0QZPUqk7Kwf9ClrKQiusjj0njAxSztaRlTf7C+aE9AAH5UQPUisM4hgz6FaCfL9ycMSlRekIPTRtVv9Ftp6YHMvmBOBGATrPaKdALIkYH1Rajc7+J2Vm/m9YWGsSVHqqSu7HZiXI3Kh9GjbQYLn8zucMIPp45fe6JdnT4SEz+hj76sywh5uRLi+m+T3vi1iyKYUYqIIIfhl9VWwYQwpMWl25m+w7qU6RnJQQom2QFPFyya573kZKbU7Z+cYN5xqsTBa9mWU99UHgoTJ5JFMJqHV+6wLUU6S3mzI3u1nS8R2VwhL6IcQ1PDnNy3AnIaBS9U7rVhkRzVfKrBHTuFU//R/XvI99YlcQslpsy+MVKn5g8nEMjmh+YvcT839332RSNnMjwehmNl0SvPc6AsyzYiZQuEeiUCWGkNRqmgQhKDROpOXpKFQQpI1mkw6WjUXBjrGl+xGoxVqqTjM4XfV3SwSYebzeljul29Y9PnO/AJStJw3gwncJRFC8KIMsGoP7oLI4e/44hAPl8N1R+aSqcfd69ctcfIU6PkdEnBE0U7yIPEgo+Ir5PEdldLceweCK8VbBPyoS7c7pEUQNc4hj3m7qtbC60IonWsyGN11JrGa+p7SaHWw7EHTV+I02RKATBxAJyhXK/LqIeiWuTClP8VcXIBd9FZjea67yv7dYridd9199qlt+ny5gEyKYXpR5XCcKxnN30/fkDuMX0XvFHyhc1Bsvl97C6oEjkFLDPU/Lm5oqYUFfpWDBPrmXLDVmIViAixfddjdtXZIjhym+MG8yWMGe4jFyqfJwT17+HEz8BlikQdR8jfLoZzJpVKMii+4s9Kq4Foral23eiMJSbMJjyAWxeakBh2Dv1s46IWnyLiElOsk8AWEDw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8582868f-145c-4b9c-de7b-08db40dd2325
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 13:51:12.4130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xZNReyvdcPk7IABUkEuvt9kupwFIIxUZcyn/yBBwxfx85EcphLtkba+fXWQn7Nu8pDGyGP2SkXJfPn+JKWCbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_08,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=873 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190124
X-Proofpoint-GUID: SOb4JX87teHYIbmFikFhb3MZd0tF6ART
X-Proofpoint-ORIG-GUID: SOb4JX87teHYIbmFikFhb3MZd0tF6ART
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 16, 2023, at 7:37 PM, Dave Chinner <david@fromorbit.com> wrote:
>=20
> On Sun, Apr 16, 2023 at 07:51:41AM -0400, Jeff Layton wrote:
>> On Sun, 2023-04-16 at 08:21 +0900, Tetsuo Handa wrote:
>>> On 2023/04/16 3:40, Jeff Layton wrote:
>>>> On Sun, 2023-04-16 at 02:11 +0900, Tetsuo Handa wrote:
>>>>> On 2023/04/16 1:13, Chuck Lever III wrote:
>>>>>>> On Apr 15, 2023, at 7:07 AM, Tetsuo Handa <penguin-kernel@I-love.SA=
KURA.ne.jp> wrote:
>>>>>>>=20
>>>>>>> Since GFP_KERNEL is GFP_NOFS | __GFP_FS, usage like GFP_KERNEL | GF=
P_NOFS
>>>>>>> does not make sense. Drop __GFP_FS flag in order to avoid deadlock.
>>>>>>=20
>>>>>> The server side threads run in process context. GFP_KERNEL
>>>>>> is safe to use here -- as Jeff said, this code is not in
>>>>>> the server's reclaim path. Plenty of other call sites in
>>>>>> the NFS server code use GFP_KERNEL.
>>>>>=20
>>>>> GFP_KERNEL memory allocation calls filesystem's shrinker functions
>>>>> because of __GFP_FS flag. My understanding is
>>>>>=20
>>>>>  Whether this code is in memory reclaim path or not is irrelevant.
>>>>>  Whether memory reclaim path might hold lock or not is relevant.
>>>>>=20
>>>>> . Therefore, question is, does nfsd hold i_rwsem during memory reclai=
m path?
>>>>>=20
>>>>=20
>>>> No. At the time of these allocations, the i_rwsem is not held.
>>>=20
>>> Excuse me? nfsd_getxattr()/nfsd_listxattr() _are_ holding i_rwsem
>>> via inode_lock_shared(inode) before kvmalloc(GFP_KERNEL | GFP_NOFS) all=
ocation.
>>> That's why
>>>=20
>>> /*
>>>  * We're holding i_rwsem - use GFP_NOFS.
>>>  */
>>>=20
>>> is explicitly there in nfsd_listxattr() side.
>=20
> You can do GFP_KERNEL allocations holding the i_rwsem just fine.
> All that it requires is the caller holds a reference to the inode,
> and at that point inode will should skip the given inode without
> every locking it.

This suggests that the fix is to replace "GFP_KERNEL | GFP_NOFS"
with "GFP_KERNEL" /and/ ensure those paths are holding an
appropriate inode reference.

I'd rather not weaken the retry semantics of the memory
allocation if we do not have to do so.


> Of course, lockdep can't handle the "referenced inode lock ->
> fsreclaim -> unreferenced inode lock" pattern at all. It throws out
> false positives when it detects this because it's not aware of the
> fact that reference counts prevent inode lock recursion based
> deadlocks in the vfs inode cache shrinker.
>=20
> If a custom, non-vfs shrinker is walking inodes that have no
> references and taking i_rwsem in a way that can block without first
> checking whether it is safe to lock the inode in a deadlock free
> manner, they are doing the wrong thing and the custom shrinker needs
> to be fixed.
>=20
>>>=20
>>> If memory reclaim path (directly or indirectly via locking dependency) =
involves
>>> inode_lock_shared(inode)/inode_lock(inode), it is not safe to use __GFP=
_FS flag.
>>>=20
>>=20
>> (cc'ing Frank V. who wrote this code and -fsdevel)
>>=20
>> I stand corrected! You're absolutely right that it's taking the i_rwsem
>> for read there. That seems pretty weird, actually. I don't believe we
>> need to hold the inode_lock to call vfs_getxattr or vfs_listxattr, and
>> certainly nothing else under there requires it.
>>=20
>> Frank, was there some reason you decided you needed the inode_lock
>> there? It looks like under the hood, the xattr code requires you to take
>> it for write in setxattr and removexattr, but you don't need it at all
>> in getxattr or listxattr. Go figure.
>=20
> IIRC, the filesytsem can't take the i_rwsem for get/listxattr
> because the lookup contexts may already hold the i_rwsem. I think
> this is largely a problem caused by LSMs (e.g. IMA) needing to
> access security xattrs in paths where the inode is already
> locked.
>=20
>> Longer term, I wonder what the inode_lock is protecting in setxattr and
>> removexattr operations, given that get and list don't require them?
>> These are always delegated to the filesystem driver -- there is no
>> generic xattr implementation.
>=20
> Serialising updates against each other. xattr modifications are
> supposed to be "atomic" from the perspective of the user - they see
> the entire old or the new xattr, never a partial value.
>=20
> FWIW, XFS uses it's internal metadata rwsem for access/update
> serialisation of xattrs because we can't rely on the i_rwsem for
> reliable serialisation. I'm guessing that most journalling
> filesystems do something similar.
>=20
> Cheers,
>=20
> Dave.
> --=20
> Dave Chinner
> david@fromorbit.com


--
Chuck Lever


