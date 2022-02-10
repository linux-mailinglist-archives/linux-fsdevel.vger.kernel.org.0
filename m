Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CE54B1381
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 17:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244838AbiBJQwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 11:52:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244832AbiBJQwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:52:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EC0125;
        Thu, 10 Feb 2022 08:52:21 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AFxQgp027666;
        Thu, 10 Feb 2022 16:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jGkILXwfdju1MNt7PdoFEbiSS/WufA/UKBwTXMEEy7I=;
 b=LenJqb6IZw5yM3BqIoxdmx6LUz2JwHR0C+l3uLKXNsepSJULvK7TG7lx6RdrBA+LoPlv
 yAy/Lmh6ubqamM5ZdrCXwJg5BMZCf8/leh9iTpn/H5TCNLSnXiNkoLW57yGwrbec+o8m
 5COykdNvSIa7PmTH/Rbm+7ro9eW6e0GEUW+JCX3BTz7H02o/RoOFQqqus0VX4gv4eYVM
 JFwSTw3vpE1Xk3maY5+tH6w17pxW2pf1wqZQeemKkWpoZ3dcDw3G+Nb2QGNICE4lBiEW
 OdrbeR3v4mcmUlEGdhIu4anOtME4g+HbD4MIVZPRRiYARiofCSFca8etSiLhUOam201g bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdt0n8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 16:52:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AGqEnt111160;
        Thu, 10 Feb 2022 16:52:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3030.oracle.com with ESMTP id 3e51rtn4a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 16:52:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDzzKTGaJnwCw53QxrlSIGfBIQu/lTPZuomXtqtU3+0FYPJVKW3XlmYwKOGmCGNcjVYbKuj9MMtMO8bioMptuhuJmOYmefwl1QD7obxS6iimt71K73DEFLylcOLzMth2h5ixcKMzO1pTaMS+UT8LCdZwQDPk+4lgkB5YlzzKjg6wV/WDVVBeRj/+PaRziSH3qiU1D1LUwqWX0CLi4FpYhyx1ZNjr2un3YO/I5PcBNhU8+pRFf9P+n3Clx0JkbfxC5mlenYzdP+Yv7bzFMwiqyDStHbodGf+za0qdtWAPGcTM2oOYj92KWw/6jh1iDROVgKljzyJ+BiRQVSZ29b79IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGkILXwfdju1MNt7PdoFEbiSS/WufA/UKBwTXMEEy7I=;
 b=d32x2CijWo2lyJT4eB7xG88+WRU326/ws8RhiTDyhWvp2P3MUbB407jIoOkIU5TECMrcNmRqjNFvQt5o4MQq4bIaejGOze9R6QC3ZvM461FbA+zr+kbVz68/g+9xgxKoWOoq39xEV6RZ+HA1Yzv6LL5GofdE8hT3lg5RYd1qjyNFqZSCzLokxBPjwHYeXG0Fw2WQxwrpWE37loxgViBfXb6GKN6Ysx5a1xv9AIvADoSD0JmgMn1SfpCa643qI3KnZLSjvRWNX9VFkB9fTLfjQcGvRgLCrysxm92CMQ6qM4lkZWR7H9YHgRFv99GJxqXGAY8pPh1of+kESY+xrvQ6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGkILXwfdju1MNt7PdoFEbiSS/WufA/UKBwTXMEEy7I=;
 b=GdHscn496lqdc8I8sRSSovhyfDMDibyFLFlq5fwN19pofisq2LpZhfTaYEJ/AMvvF3kGIDCY2esVnogQniFdxnabLL80w1ECGope8aZaO73gerT7sJ3bJJchQCOMc+gvbdxaESzo5bmppyvM8PmSrujJuqFef23J3OzLpuQSg+c=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BN7PR10MB2580.namprd10.prod.outlook.com (2603:10b6:406:c3::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:52:15 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 16:52:15 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v12 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v12 3/3] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYHjn74pyZfV9hjE2Fdxx9lh+2gqyM5lKAgAAUwICAAAWVAA==
Date:   Thu, 10 Feb 2022 16:52:15 +0000
Message-ID: <2223051F-B8F5-4E59-8A27-735F6A426785@oracle.com>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
 <1644468729-30383-4-git-send-email-dai.ngo@oracle.com>
 <20220210151759.GE21434@fieldses.org> <20220210163215.GH21434@fieldses.org>
In-Reply-To: <20220210163215.GH21434@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07982290-accf-4c07-3724-08d9ecb5b145
x-ms-traffictypediagnostic: BN7PR10MB2580:EE_
x-microsoft-antispam-prvs: <BN7PR10MB2580BE8EF1EEF50C6DB12C0A932F9@BN7PR10MB2580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H+krGWSnJVuscwVC8TZ3Bt6k+nFt5YgS/W4WFWWXNR/KYMbwJ0KlyargpcHmogkp58GXybzvmT8qqis/WJM6xqVSKG5uCfTFpemYqKjOYYKaCA9cBuZI0pyFb8KHfkRtdE8fm6+o30avmWQkaquMjjBnQencCyHKZU/nXo8bIEliDQuZtgPvKe0r85ORMoHC4yKcetMqdD+bbjsv2HJjySWIlKowTxMtEW9N5eZpgHoLFavoU8qXkGXYdwpICtbZQ08L3pBiovUdx5XTNgQ41FCWasd9xFznTx8VaUG9sKa5PTlsrGcEFRJqs47Llnv1xdWRCPUU7MqXCeRLfjGK8iB+r4FsBEqrPCZUgUcGU4p8xu1kBlisptIM8GLneaZLTkpSCpTzTODxRgPh3XjPhSvXBXweO2rxNcoostlrVzNUpPaZSXg6LXm7ifQRGyclxDAblGjMlCWxvdL4G37Z+tOTmumIcdVOmYCcXc90oVAk1o06gSXkg1hfSkp6ImeaESWPjBKPEJn1SxGYOn54KPUk/BND40ss+SFQfOkd2yGKxo5Lbr0wdd26zgQFnpuUBBDrtvAwqjUf48PYr3JJLqxFLhI1u+Uecy1hMj1LZwK2iw46e6wGh9my1eSmrY/NAXOvymuILvD8jkl/5KHzdznWl2aSG7SHQbOnLm88jYGT05GyrNIt0QMCIfQb1V5mnjNQ/pTroNYwrQHaUGeJctkQktrgGrZ57LKH2yjc9Sw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2616005)(38100700002)(122000001)(86362001)(6486002)(6916009)(36756003)(26005)(186003)(54906003)(33656002)(8936002)(5660300002)(316002)(83380400001)(53546011)(6506007)(508600001)(2906002)(38070700005)(66476007)(71200400001)(66446008)(66556008)(4326008)(64756008)(8676002)(76116006)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KmU7U/VTFRhylVoZ1l8H/2x4mLq6fELJFIRWmpFa8Sq7rjdACQAwl6vL6jCd?=
 =?us-ascii?Q?kQ4/hVnBnyC9q29srw9hP72fqEMPNiZwdXoCQwkOQjtvvoqDoTZBujbfOoH1?=
 =?us-ascii?Q?8q/sE76f1c/UNAUU8UU2NejLbnRvBLqdbd4dD9+YlaLORJDEiCxxEAJVGdJf?=
 =?us-ascii?Q?a/49EouACYmAm1vh5uHrvUVuaD2QxYiQnFqOOUV9Cm3b0hrQpBMk/2ZPn5Dk?=
 =?us-ascii?Q?5z03028Dpz+evnhW3Zh8IAqNoRWWoC3DYVjbYxY2QJs0VnRg3GlqOb+k/Q4s?=
 =?us-ascii?Q?0bgv6Tn3wcWdq4ebKuSgMPB8GNTHAC0qbf3HWsxiZ/Q5n1Sitw1cxhBGkxvo?=
 =?us-ascii?Q?1OwTyVxTfTf4jQQeNtrsRH7bje6lRM+TbvJbvK7PxJ/V51BIqiybySTyaY3g?=
 =?us-ascii?Q?yUmH19iBm5eorgSnNWXlCQT/Mq15Xm9tk5rc2/qSTmhZ1JvN7IxvI+wrhP17?=
 =?us-ascii?Q?G33RQRu1QuKhOrUtMplKK2R/ikVeKkjWwi+Zj9tyYmHVTvC7Hprl7CZsHkiA?=
 =?us-ascii?Q?hzBwo5MKo+BbJx4Ynck6o17uYURwA4PRQEtmo3zvpb6V85OVYOo+hJqvtNgi?=
 =?us-ascii?Q?IhmHnJqDLUBfH1izH/YRLBc3SDGbBfg6MkEcYdPkDdFuUpevdTs+CMs8lPLv?=
 =?us-ascii?Q?bRlHI5PEbQEJVRvfvhhKTMelK3THA08PpqGbcllikhrfCrOviK+zcIW8KS3k?=
 =?us-ascii?Q?t0/CdnRmCmvjCHMi0HNN9jBd5g4R8HOEUrY2UCKvxFsH+pVO/bDWfGs5zocv?=
 =?us-ascii?Q?Z5gx6g61Q4BbXrBglo0Dqgs6xY6+Z5mTzWViY306fwF35KCAUqxcE87Ina8r?=
 =?us-ascii?Q?/by6oNarz8v1JFhCyW0MSNciBmSVjUg6/ToqHIq+kVJ7gcTUbrvny8BNxvTr?=
 =?us-ascii?Q?SK9p+CoOZsFy0VCfu/aWPAsY+U6pwAUF/Bmsw3xiXn9hQ8goD3ZhUN4pQ4KI?=
 =?us-ascii?Q?s99/K1quQaQ9uIuUpTHjpDyNcvdN+vSkyCVVmWJ3nb4Kd3GzmuXhv4H7Iyaw?=
 =?us-ascii?Q?V5XuqaFOdQiXKJ+ob94MNTg6IwRS26iVq/OYI9KLVDHevFqKFYAYDyVHltvs?=
 =?us-ascii?Q?ipI64M2aEW9hoyMu4qlYydZG31cLznCs+/Ni5tX87Re2H7eydYd1cR/YvvlN?=
 =?us-ascii?Q?4y4HnIkFfupEnlATeZmCsEnwrGumrVAyIktkxR9fDEf1zeB6YbDdBu5LGYyR?=
 =?us-ascii?Q?nTBBj5HwkwOdS26zd4i6rnQPv7iyM44bx1gu7kbpEURdcl2Bnb7CX1Df8ALL?=
 =?us-ascii?Q?dEnqEzktMUqcemqEM/rS6x7RPV65stKoujBb5qJneMqLeU6MLmArrPw45rVO?=
 =?us-ascii?Q?McVJS/49d2aGrpVqTky7HY8w6pT1yMzpA7sx7jQS6EA2DWhiOm0allBJ+cGi?=
 =?us-ascii?Q?q/gpJcXN13mtCxDZKu/pemxQ7nMS7pKlL7jmPDqGg4cmK+shF2g6PA4NP2Pp?=
 =?us-ascii?Q?T1BvtadwIbUdplsGudHyamHqtVRT3SJTNF4T2KzqFMmMpU5ruurrArW/xQiB?=
 =?us-ascii?Q?NNjx+os2z5NYcI0OFMe4AeySEmZsMz9CRZRMXKr331CtiRl7N7fIK+xopXKy?=
 =?us-ascii?Q?j/Ib7qm/Sq3pB/on++gntAHRLqXdl1O52kxb6job9M+MBtBUwK9XnOq4B6LZ?=
 =?us-ascii?Q?wVeJ+CT7MQ66JM45uVMLmdo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10B317176333DD4DB0B2D5DE32EC86A6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07982290-accf-4c07-3724-08d9ecb5b145
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 16:52:15.6193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovVXaCj4EiaV9C6TPclihF0sgCfz0aeDDflXc8cBShW9vqsmQWYtdCvd+PdYqCtWCKdAOuKcxKl3XEdiwuzYdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2580
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100089
X-Proofpoint-GUID: UZHE4Ku4XyDWanAsrN3XsdNFgVFEUz7X
X-Proofpoint-ORIG-GUID: UZHE4Ku4XyDWanAsrN3XsdNFgVFEUz7X
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Feb 10, 2022, at 11:32 AM, J. Bruce Fields <bfields@fieldses.org> wrot=
e:
>=20
> I was standing in the shower thinking....
>=20
> We're now removing the persistent client record early, after the first
> lease period expires, instead of waiting till the first lock conflict.
>=20
> That simplifies conflict handling.
>=20
> It also means that all clients lose their locks any time a crash or
> reboot is preceded by a network partition of longer than a lease period.
>=20
> Which is what happens currently, so it's no regression.
>=20
> Still, I think it will be a common case that it would be nice to handle:
> there's a network problem, and as a later consequence of the problem or
> perhaps a part of addressing it, the server gets rebooted.  There's no
> real reason to prevent clients recovering in that case.
>=20
> Seems likely enough that it would be worth a little extra complexity in
> the code that handles conflicts.
>=20
> So I'm no longer convinced that it's a good tradeoff to remove the
> persistent client record early.

Would it be OK if we make this change after the current work is merged?


--
Chuck Lever



