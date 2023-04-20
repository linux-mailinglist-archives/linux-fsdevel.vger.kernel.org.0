Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68FA6E9762
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 16:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjDTOl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjDTOlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:41:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25C54205;
        Thu, 20 Apr 2023 07:41:18 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KDu12q013171;
        Thu, 20 Apr 2023 14:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=fA6RfKjJiwLqfDgy4cSc/ZqAKURiq0a9IpwG31uwPHA=;
 b=fhyPVibkQ/Ba0ShANge9jw+sZb/ZdEN3Bl+0Rs+6mfmZWGLMy8OISYPfKI6IM5e3Dhq+
 L1BwNWIbGCUpYobGDlINQKZ6+cYQY88da7B72cu049hX43/7oBgljQdrRUscsjYeVAht
 fJbrIIbQHZNhpX5YLQZSPULSQpf0e+A1ky/lx5vNoRwapcdVpIAE6FOn/5E7eQKOc1Hl
 hJrxnWhQnXmqRRVZEVYSBn4ox2s+lw30AaHkQIWgwNZocNnMwbn0yM72Bs60ZegQIH0/
 KGEbKMX7fI7+REhXuIMwkb/imXQurbyZYG3xsUrDI/53qSlsMScfaCh119tKuPxygk2p mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjucb509-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 14:41:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33KDB4Di011217;
        Thu, 20 Apr 2023 14:41:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc7vjp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 14:41:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL44D7O7pqdAjfkisLyguL9Yn7gOe5iKH08TfdHJf/6MMJmcEurZzjf2LSUjeznwf9QfmpTjZmC/zO3vXUGBUl5DIpntwx2IWlnZFlbI63pcRumxmUhnqrrUk3khCbal2kQMGaCNcMJsMf81F7+J7fA4wqycrg1TxBcuFZIbYvOXQ/ptGp1PNNrA3DQIz9i1dDSgM4wIjoFjwsLF8Tp/Y2O/ifi6UHDQfmhufMrDLWEdCHRzGDsxwBEbbblrtZOmYi4rDoFCVA/hpuWCktwBT0Rpa/oC3RTZWsQ+4O/MA1uku+c2eIK/QqQhAfWIewypG2Hml9RrM6kCWmsNSRI7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA6RfKjJiwLqfDgy4cSc/ZqAKURiq0a9IpwG31uwPHA=;
 b=LkU/Usrgn1DniPKNvYqwzTTihwLZxaLSFftVaxI/tgWomelhPkdwVMJGEHwaqG6uafmnNNmzTQZ+s+27WNaZIS5xiXPu2eqG9u1YcE//usoD4MSGEY26bgveMyjfPrx+OXzh4KgMnO9ne94JUs74hy12K98GYq5GBNAwD8HaAn7Ax1qs7fw+tapZJ9SJeWwapkcBIXPr1itBuDCF42xcg5FsHHI/t4lQIXp9GmWDjhfN/krPCTufnSfIpUyfnFhMOFApwY7whR+8cwSTDeIbpa3b7s0gTeGjvA9nwOPN9Tq31xkkBJ9xQYaGhVvrvhkB1K8eqM/0CUwK/cFCGxGq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA6RfKjJiwLqfDgy4cSc/ZqAKURiq0a9IpwG31uwPHA=;
 b=vkBntVwH1oCyZ6lv+NvEPRzvT+01orUM/XQDH5eRimxCHY5a5gWqziq7NIHqzWCgqiuKoJxDGyWzwejVunDt9B6llJkxsGh63v8yfjNw3GBEGVmx76gce/1fdsr/qCHKp7T2O6RzdSuQmJLW5Z3NmB66pEcfIK15i28kEgOLCV4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5334.namprd10.prod.outlook.com (2603:10b6:408:12f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 14:41:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%6]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 14:41:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC:     Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Frank van der Linden <fvdl@google.com>
Subject: Re: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Thread-Topic: [PATCH] nfsd: don't use GFP_KERNEL from
 nfsd_getxattr()/nfsd_listxattr()
Thread-Index: AQHZb4qhR4jn7R6+a0evVV4Y3qmRcq8si0OAgAAQUgCAABjIgIAAToKAgADRqYCAAMVVAIAEEwGAgACihoCAAO0BgIAABu0AgAAJ1QA=
Date:   Thu, 20 Apr 2023 14:41:08 +0000
Message-ID: <DB84BC71-AF42-4682-9D55-AFD907FF0874@oracle.com>
References: <72bf692e-bb6b-c1f2-d1ba-3205ab649b43@I-love.SAKURA.ne.jp>
 <4BC7955B-40E4-4A43-B2D1-2E9302E84337@oracle.com>
 <b014047a-4a70-b38f-c5bb-01bc3c53d6f2@I-love.SAKURA.ne.jp>
 <aee35d52ab19e7e95f69742be8329764db72cbf8.camel@kernel.org>
 <c310695e-4279-b1a7-5c2a-2771cc19aa66@I-love.SAKURA.ne.jp>
 <7246a80ae33244a4553bbc0ca9e771ce8143d97b.camel@kernel.org>
 <20230416233758.GD447837@dread.disaster.area>
 <A23409BB-9BA1-44E5-96A8-C080B417CCB5@oracle.com>
 <20230419233243.GM447837@dread.disaster.area>
 <234CFC61-2246-4ECC-9653-E4A3544A1FEA@oracle.com>
 <b6256ab2-35f8-e5e5-59f5-10ba95a396fb@I-love.SAKURA.ne.jp>
In-Reply-To: <b6256ab2-35f8-e5e5-59f5-10ba95a396fb@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BN0PR10MB5334:EE_
x-ms-office365-filtering-correlation-id: ee5fb1e8-7331-4ed9-4e69-08db41ad479f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 83aFel730O2XInKSeiiMAOXoE8aUvA4ZOFPGJjrzgLyLlJd2DZ7PoTNn3MH0FAf0bORNrM8Vb3d5sIesfrKaIOarYQ6gDnOErM1EaEl0YFkKmOBZC/ch3QFcm8UHWOjJfpWHxdDS/+sXiu1iLReFrgEN8NH38aq0QvQN1J28jAgEZTmb7kwCmI/IxfMnc3Jzt1VZde2pigw4BbAOJpldnu3KWVZF/eZ6dxbvaoYe7vWO9/fd9QH4B4er3ng3QoZRzFJubaDybusYrwJyY3SL9oeQrsZeRkkLqWYHWBB5VYdLwpsL8F4DZu2A2oiECmfwyQurW36bLAZPIzTZGKxWqNTbKbXGAR7kjIbEiNcfy3OpE1cTe+ZPrqlqaoGDkuzTaUwHPSJ8wpbMb2XNIkLvVik/J2bYVxZrGbDqCWp2YsXPQUrJeLkAbr8qua0ru3EFHZfG5BKSY7TTKCb98ZkDyDpRKNbrJh+FRuoymSp9CYUhR5qSHYVNLqZaAS4t3TpOhA8GvDrwWbq/lSqnjYCbXui+lzx65pUc8R/dIHirHdeckHxX4DUHNydeGsEmG3AevC/2t8Zr+bJ9fbfCSn6+D8tr3eIPPwqwlMaMiwby4xq8nxb8rdQAyzn/BmItGUMhX8rP5W3STAIrT69G7bPCmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(53546011)(6512007)(26005)(6506007)(186003)(54906003)(33656002)(478600001)(6486002)(36756003)(71200400001)(5660300002)(38100700002)(4326008)(2906002)(8676002)(38070700005)(316002)(66946007)(64756008)(66556008)(6916009)(86362001)(66476007)(91956017)(66446008)(76116006)(8936002)(41300700001)(122000001)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EylU+Ei4TLWcwlSo4n8IKoULiccTum78EAoza5ZSvllkOtywqjgxZ0BIsQq/?=
 =?us-ascii?Q?mdDNmosH1uj0UJ5KYfAiQZ3PotR9k/imaxikU8FWAs/arm4PyX7vrxVmeSui?=
 =?us-ascii?Q?uRjicITC3Sgif1RDyaYRclmyvSNV2dMBbLAfZPWdVeMA1CROb18wM4vcmZ9T?=
 =?us-ascii?Q?sTvX/D43GUoHxJcDYMKpIpZh07UR5tmvgVnsWW36wHyJiQxUYNwtsFky/Xvg?=
 =?us-ascii?Q?syKB3eZEnYEQvEPUll8iSxakgeTJRvi9GmZt6i9QcbkZSoDbY3Tfz2IDLZx+?=
 =?us-ascii?Q?edqzIiCPvQDJLU55UNP8jCv/5opshLKW/kWZiXFP9q2CmY3jWQFzPlVmqv0k?=
 =?us-ascii?Q?TLJG2NLUfljhJDHK81LyF9gg4iAnVfZqsjy92F1/HMF0kEUkaQuo7wddvWcw?=
 =?us-ascii?Q?jEED5BhgkhTjtklbOpIbJ3MmjMwDkmPfThOpHrdL10WdrkV2DmPvPXDEZxvx?=
 =?us-ascii?Q?NifnhIdTgBcrZuM5l4y4J3NGckvK2h2nRXe8SpKAmquvyQTSOX2juUuwJKVm?=
 =?us-ascii?Q?7GhYM7qhKUJXv4d/681maFMArTsltSDRQjf8aOfldDT/1B4xWsEa+O8i3JxB?=
 =?us-ascii?Q?x/foe2xBzOuT2ak0Hux+IyLbIfcjdTQzxmEot27e2lJ3yznUUszNQZNGSKzi?=
 =?us-ascii?Q?RBCIOq3RNAtnrEGOtJx5g+YncsPawwUPKycj1TBalwn0qkr+bZ8fvH/w0nY7?=
 =?us-ascii?Q?utD4jkLbQVZeqzHpyLWL006kEgG+f6N4Tp5CdAIeFQFQbvNwMuV6OaHtKYz5?=
 =?us-ascii?Q?/SVtrPdFbF/pMdfqpnqJV/JvV1/MypY7ejYX75hLc5MfzfHh0mYPHilp5Kxd?=
 =?us-ascii?Q?8fO2JBZdnHvZb8Mbxda2XdNM8mcZXUI/v0ycLC0aowhMvtwD6C5pJ32VUhH/?=
 =?us-ascii?Q?N7UzQZELf0ISuD8RIJUZWm5SfVALOPEmM6IwfuJS+s7k8mibUbWCpCfkeupH?=
 =?us-ascii?Q?3hooezpWuUN2w0sanpcTul6ZhjaPSVhlhpXZVn7IzjZc7NBYzC4BolW/ja2I?=
 =?us-ascii?Q?dpGwcQ2mxHcxwrCgl8oQh+TMdG2CtgX713Arij1pGxIdjA8/MZc/VJVlEdbc?=
 =?us-ascii?Q?kueUO0R0ZBMrRFdzXv6783icOFoJwI4FE9QHj3obXRNO5xY0U3OXnwnmsmBF?=
 =?us-ascii?Q?yC9Zc1rO/NUgywRdR7kdUuxKFtc8LYaYF31aMwojkuvhUEH99mC0BDHEoHhH?=
 =?us-ascii?Q?82dL5k0g78/zzXAOiLJdpR+sGmfx8/tH58QO5KiRR7aHLeVuSM2t3jqUzPsM?=
 =?us-ascii?Q?pI2k9S7HuKdTnf0rTyeka/wg9W5W4Mpx5s3AmpNodFoYBrdFBZIDfAuIqkpV?=
 =?us-ascii?Q?jZai+BxNd9fPjOfEmjyxk7dbbIsN4SrxquuR7Cs5kF+IdR+9317UFDw33J8S?=
 =?us-ascii?Q?PIm1n1n7e3tXjrfASLMG9mh++QnentIRG5BkAwl3nbfaj9mxYqF5N7aYxsx2?=
 =?us-ascii?Q?tqU/ZinyxJEcyzB1PhcfltUDXM+aDtFjZ5yhmBFb3xcktb/8p5eHj8/0up+7?=
 =?us-ascii?Q?bIKMNOSeBqHA9PgE753ILH+xwEKJ5CcjP3HYLK9vl5+MDYAKcXtliv82Xr8A?=
 =?us-ascii?Q?cEZQ852aF4BVaqYU6MGsYn9ayWJ6l7txOZLQttZs8jnIJv/A2FIuQ3UdxdlJ?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8059D42663BED84DAAF388AD0CEB4900@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: viBLO6OMDNSGgj5JrcEMT4ZXCItqfBs+ti+ZGC8ppeyJoo61zNhLiGRTkogXp+Dhjm+5rF9utoYroejm60Z6f3ssiZgiE5U1RSRrNjCSX5mBe3CkhI8m/Ky4ep+G97W5dImqb0whKgQ1fuW2Fa3LhDPD5ZVXFXVOb2zPFHEI06Npskx2sNsKCPGAeb/CjXLVRXjv4sZvHB/j8+bnoZqxVgsr0r971PJkrsbF2qDIOlCkMn0N2fM2IUHEgy9ZePMIaVVNU8BLnZZ9pfiZxZAiye0fVBa2G5O6IMpEznlDCTx4mqThVzU70HIdQxz0UrFXyIfnec/gEByEjBLHkEFRYBB8squx6aWnNKIlF+N5t7XIvtCtmEtmdDiVyHL8FV986+SmId65RLV+dJYmFU9nKaseK1KAZrDHqKcWL+XDbGM1ih9n9e6V5vNeE9doPk5jUHqXmkFyrfNtmLbST0tYUNsuSMhXvoow0VWUE3lqp0czHgcJKyMzmQxysfPlFPEP8Y8DWe07+Lu8zRftHVLPPLqfs8wAjZZAArIghsibXU9LCVagTNkqE6co0ebaZcgaDzghrnbMoLhwdED8Ljki92Pi6Dnw/WLW5sQGytG3JZ9NRHgGIYg2EMdhFK6aM6EdBmcyQQyASX3oPZlgXuQkekzu2/read/2BkZ0SewQ5R2plhNXcNTo1fV1yCaPH+CfDUOAN0G91N7Z+7yBd3gtF4c2hnzQIWDgvtm/3ivUET0t/6NIbRntvxmMNFE/P5sgpDYFS6xgEAgkABgjp+fITSbPHlaxa8gcj/24IV8hyV6bXS77IcalIOYeiM1u/lSgWjhCYGXZLmc/nAe6XIPUG3WtzRYGnzYVeMcR6Bh2esO3vyoVQCfgFS8RwYiFAJU/cCJq+qCoDxKIoX5cbgOWnap0jeI4JMzowQ5h8nCS3u0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5fb1e8-7331-4ed9-4e69-08db41ad479f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 14:41:08.9759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyGJkOqi8wePOe3222j/dIxttWQaUsr3bmplnN0zygsLdBhaTiHZlNnTw5oz+j00cZ1J2FsH3TgUslJW4DZOiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_11,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=389 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200120
X-Proofpoint-GUID: 36UCaVxFaSNg0s3SS21P_0Nll8JRX1v_
X-Proofpoint-ORIG-GUID: 36UCaVxFaSNg0s3SS21P_0Nll8JRX1v_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 20, 2023, at 10:05 AM, Tetsuo Handa <penguin-kernel@I-love.SAKURA.=
ne.jp> wrote:
>=20
> On 2023/04/20 22:41, Chuck Lever III wrote:
>>> That said, nfsd_listxattr() does:
>>>=20
>>>       dentry =3D fhp->fh_dentry;
>>>       inode =3D d_inode(dentry);
>>>       *lenp =3D 0;
>>>=20
>>>       inode_lock_shared(inode);
>>>=20
>>>       len =3D vfs_listxattr(dentry, NULL, 0);
>>>=20
>>> Given that a dentry pointing to an inode *must* hold an active
>>> reference to that inode, I don't see how it is possible this code
>>> path could be using an unreferenced inode.
>>>=20
>>> nfsd_getxattr() has a similar code fragment to obtain the inode as
>>> well, so same goes for that...
>>=20
>> Dave, thanks for handling the due diligence! I was not 100% sure
>> about code that handles xattrs rather than the primary byte stream
>> of a file.
>>=20
>> Tetsuo, you can send a v2, or just let me know and I will make
>> a patch to correct the GFP flags.
>=20
> So, this inode_lock_shared() was there with an intention to make sure tha=
t
> xattr of inode inside the exported filesystem does not change between
> vfs_listxattr(dentry, NULL, 0) and vfs_listxattr(dentry, buf, len),
> wasn't it?
>=20
> Then, we can remove this inode_lock_shared() by adding a "goto retry;"
> when vfs_listxattr(dentry, buf, len) failed with out of buffer size
> due to a race condition, can't we?
>=20
> I leave replacing inode lock with retry path and removing GFP_NOFS to you=
.

Jeff similarly mentioned to me the tactic of simply retrying if the
retrieved listxattr contents exceed the size of the buffer. I think
I'd like to leave that for another time, as it seems to be safe to
use GFP_KERNEL with the inode lock held in this case.


--
Chuck Lever


