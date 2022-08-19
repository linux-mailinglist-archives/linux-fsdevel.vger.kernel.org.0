Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5B1599E13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349534AbiHSPSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349507AbiHSPSo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:18:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09BA58502;
        Fri, 19 Aug 2022 08:18:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JFFR8x019891;
        Fri, 19 Aug 2022 15:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=B41G1mqmR76pqWqcxraSHD5S5rFcZakdUOKo9QLY7zY=;
 b=v7NPHmMeR/tANTJzq/791JsfhA6zwnInqN4zDw4WdRXVgEyVISCt1jUrpfdQg6d9jx7I
 xfjOEdsraFZ4ZSs6arv8XoQkMKUHLNjZ2gpMNK0+G8il+8WExoNN7IK8iFG/dVeTX60+
 Re8+xrdDp8cc35TZRrGQWpXfKzR1v+pRdoVSQV1zIxkCulfdZ9p97fX8BREV0af/TmLz
 nDr/H+5e2MIvZc/2+C2B2mDq3fQWhkJtedtb/PrrFSmKVfCi4JDnIDWERoMUJrzPuXZc
 IiLmKvs3Sd3xIOXPXFldxQYlmexQXBcUsJxFQ6BbJO6gwJ0Rup6Yy9yP5d2DHIU5CD0o XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2d07r090-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 15:18:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JDpq9Z023770;
        Fri, 19 Aug 2022 15:18:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c49w58n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 15:18:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2NzPTX9Fl1EuTy85ncMRMII+WN8L5cOCaepc4YWBi6UXq4nyLhyeA/PU43MkaLC76R2mTXLx8hkP5LxCpw3x94RShZqjRJ7SBhPgejUTzRfsGNMlfx35KP8Tsq7P8qIFDtK3xYmUH+fn6Kn9jCDMqEEj5LlNFLD4dC1CtjaaVpVMQfc1/vr3uqfG8W5qM/PIp8qTyE/frfrJkwpJXUQo6ZgZvCo6x4F6Rq6Racok1KfNkANw7a2z32Xt+sOfAYb3Qogru48RmWs+tJm1rbsfqeUc89OAjhh3Wmbexjup4GOEYAGH1XZ/MknYhZ2Se9mWpCExPuCQ2c8MqjobASisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B41G1mqmR76pqWqcxraSHD5S5rFcZakdUOKo9QLY7zY=;
 b=HJj0qQfkmZoR11YOGPNLrakdK01DBZkQi4jmj26ko7iyV0WLHOc2b1dTbqIK8K/Hc38S1pZsYUBEHLccKPVdtthVN8C275p2U6qSEqWTKh9EFuE6SVg/SMEdZ8jl0Rxkb8KjeVcio8ixsuxWgPDUVT7JPZg4tuou57+6fdoR0Cn9yVvc/bSHtIxuxCCJ3SgXWhAaYtVM9iNOU5vfNP2bpjg8+NUCOCsOAd62POKspiwkOsU0zgZF7/kzRKc+JIQ3qXCfkbN/L2m/9Uk1QZZZeDz0Y1DMim0LCwlIrW0ibfPUnex4WJ1aSegldESPUYEX8+UPCpbhK79MALUG2fyIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B41G1mqmR76pqWqcxraSHD5S5rFcZakdUOKo9QLY7zY=;
 b=FzAy/WZt4zDjUowDBaF6mT50wwQYJRQT0sHc6OgLi7Jp1aAy55s+RnTzDLyoUNf4IH0ch9VvUtCb5Ll/NEbyIVT/1ni3PCBdBp6beqIuCMxfjQMuIQOZnwKnCdS95gmM0Hms066tOK0MaSeMfOs923DuxRUcVZgdr4kBZO8QDGg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6035.namprd10.prod.outlook.com (2603:10b6:510:1fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Fri, 19 Aug
 2022 15:18:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::91ca:dc5:909b:4dd9%9]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 15:18:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>,
        Dave Chinner <david@fromorbit.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <Josef@toxicpanda.com>,
        ng-linux-team <ng-linux-team@netapp.com>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Topic: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Index: AQHYmHrzYsqP79DW8UWdtY79IK5gxq1/y34AgAOLZACAAtl+AIAAIOUAgAAtKQCAABONAIAAHJ4AgALo+gCAAPGRAIAqp2UAgAFcVQA=
Date:   Fri, 19 Aug 2022 15:18:21 +0000
Message-ID: <BFA36FC1-FFDA-4F98-8C0E-DD3DE47A50E4@oracle.com>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
 <20220719224434.GL3600936@dread.disaster.area>
 <CF981532-ADC0-43F9-A304-9760244A53D5@oracle.com>
 <20220720023610.GN3600936@dread.disaster.area>
 <CD3CE5B3-1FB7-473A-8D45-EDF3704F10D7@oracle.com>
 <20220722004458.GS3600936@dread.disaster.area>
 <C581A93D-6797-4044-8719-1F797BA17761@oracle.com>
 <CAFX2JfmOO7RK3SirXLrRA9kpBC=ROnZydYBje4rowxi+vdoJLg@mail.gmail.com>
In-Reply-To: <CAFX2JfmOO7RK3SirXLrRA9kpBC=ROnZydYBje4rowxi+vdoJLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d947b241-6bc9-48d3-ed73-08da81f60d66
x-ms-traffictypediagnostic: PH7PR10MB6035:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 360WO2qCsasYXidVfi22yWcvdQDFX4u5Sf2Enyy4EWTFluJGIZEU6INFTgLn2EykP3Dq+BJLZJTyuEZGZr72kix3NRdQDDXPxE6ZQunfzTBTsy31V39QE0u3Sw5xB/Q6pOS0HoJBqGPHpGL/o+PNh+kUCWCY+0cNBapy+NqCs+tez9qFmI8VNGd8lioRdIEts8Kv9PM3Xdcem+VefHzxTV2RmfHm61r4i6AEQqeqHYFpTsM6u+H8uu2rqwJy+DC0iN82yItmqQPItI8uQM/KVbgMogKMioj4TgGPkCZil57SPKeqQ+1xk7PM/c2kAUVx08+HwQzZc0kzKbwNJHtYViOvXXlGBpKxxDrpX80X4KloNSSQkuMO697aIbfAzACqb+6Th8qDzCyfId9lYNqUusSqYKk7y+q7bNC23ffRNDFx2WWLWZ1zc6U5nlJHIaDalLTyFKgDW/cuWzozhD7SEIJ6+tn6Uy5b1kNW/ZplMvpP9BenB4uUG6h2PGxW3xbYCuMA//FpotCc4ijbzffx/rAxzJEAh1vHGhdsbr1iayEkyZnJOn3nnmBnfEdTRVf8NPV+HyjnnsKCvH5ekjxO+sKN/YTOj9v6jwoPG3935y48lPt6f2p6XuMSk0jrsGFlx7K5b8uZpM3bno5BWpd3ADpksSmSlpCsettQmmz/z86TVKwDtiCQXxXcRy1QmN+MPKizSMAfCWq3VuiCn89rcK6hIoaY4ZCU+1YgG0ii8R9Qa0H8ubMQf6+i8vWRQFkXbtXlIw3srhRhxIknk4zfMMYs/FrlQHsF0gHy09W2HVk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(346002)(136003)(39860400002)(83380400001)(186003)(2616005)(53546011)(26005)(8936002)(2906002)(5660300002)(33656002)(41300700001)(6506007)(71200400001)(478600001)(6486002)(6512007)(36756003)(66946007)(86362001)(122000001)(110136005)(76116006)(316002)(91956017)(4326008)(66476007)(38100700002)(8676002)(66446008)(54906003)(64756008)(66556008)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yko6qlETmI1nVnIDaqPGUN8rS/D1Jb+49TiQQlOGj8fmnBfkw6hrwBF3zRSV?=
 =?us-ascii?Q?Ghl+wCjRyToPlQ0JS8ig1ui1Re55nqdBD+sMHFNFrPSwbtyLrFxVG4mRDBPi?=
 =?us-ascii?Q?OUsGWtASJf0jqSJeIoW4G+vkL+Su1C8NEhEyTl6MtQ2u/M9KMFs9NPgDnEZP?=
 =?us-ascii?Q?4JX/6CXTJoj/VfP4i8lSrdowp7bJzPmNN6BVyNKIQ8vtHgQw0gKBwAVMAo6N?=
 =?us-ascii?Q?a6qHKZSrDYNlPXjquaPJr5YgAjRTsje1m0bU7Zg+TLcgiSGxdGg0xVH5bYF7?=
 =?us-ascii?Q?2A59Ly0su6YNhgVHZnKnFYSPsLNiewejV1jkmBUyf7mjEtCMPbYLck+IrG54?=
 =?us-ascii?Q?FEgnow3r+AzVaycjaccUiXoxyf0Z8Aie/QU4gEH12VKOi16AhuxNcfIZpdl6?=
 =?us-ascii?Q?QkaYOtm9I2QLNIQwwCXndR9ruSXlDK8/hKeDQBNcQJK4zrwGEJdAukOkKlrP?=
 =?us-ascii?Q?iIJAML1rJQdopeBg2su8PbVqQGk/WOiUBJF1/EJAhcfnCcQ72+o+r9Id1Zy0?=
 =?us-ascii?Q?sduX99GN27bJfFBoIAZdfptwzsJZ1vTdJPaL3Z351nbtVoh/g1lKmmY/+O5O?=
 =?us-ascii?Q?y5VesFW9mB9pcSunucJvRvaRFSvcfofZyGRVwA9WkoY/jeC9xCoWk1IfPKul?=
 =?us-ascii?Q?SOhkFDq/JeCF3bADHTW1hkkJDN9MJKXY6h8kX/W43ACdmgQ03na5xl4IVPZY?=
 =?us-ascii?Q?VHwY2Dsm/qPqmof8r3EB2fNkfDFmGU49UIkBcKJ96Lpdmgp469iieqfUXIUJ?=
 =?us-ascii?Q?rwk2q59ZXln1abyuVorfjTVLujhW79JfvTpZbtTVTNUq6LkjJ1desAcZPAYw?=
 =?us-ascii?Q?BwtqFHlQwi5dvN1mBwjjc46hPEVI1s1/Mhv6rbgtQMYD5jA8wk+vesf9Jbr2?=
 =?us-ascii?Q?cNo0fQPvM9ya+wYQeL6FmcpYHQFICyrWrgu9Xdwalhn/5mGFTbyc+DqO2u/f?=
 =?us-ascii?Q?GsTA/QXrBKxp3ns++6p+5LVWQRTdClUS2F7W8VvXGmUCXdEEmEVHgpDrI8Ym?=
 =?us-ascii?Q?LYL9Y8LAIfLSYlC95kIuh2/P5ULpXT5WSI65AOxMcT75NAk+ojTvBQ5KkeLH?=
 =?us-ascii?Q?+OvXnBGUb8YIE4cXhMeVBaMaJTCtp2Bk9yGSyC3gPwLJSe/nD+HDwrwYZ+OX?=
 =?us-ascii?Q?2nYFiEykCLjqLX/bXPdcfrZ9JH9FfDEHQp5nDOGe5+HrgIiTu+6d+dft+scS?=
 =?us-ascii?Q?QMahP1zvziXMjV2MChG+TXJpzFZq+EqelwmGIjdxL3eIQwGKREY/ZVU+Wu17?=
 =?us-ascii?Q?1U0jhj3dsVpMkm+cZGr04fB0nyJEKx61rgzbQR0RDIlttuuhkKqO3kGqSTfQ?=
 =?us-ascii?Q?nL2UGaPCou/ylAagsb1xqE/OYrkytz5e4Us5Xn6307dIpqrAzJITGLdzyFwF?=
 =?us-ascii?Q?83G5rap/HCMdct0GScJJwKW0j7zZmcbpCLmys13ry5rwUMf+e2XeWdTxyvKB?=
 =?us-ascii?Q?yej64sNa6hCAGEf/GOcuZSeh7Muq83sjHjEFuvoodksDGkuaDFLLqb7XiWWH?=
 =?us-ascii?Q?KgcbUXVqsYO2C65fZxFcOwYH5u4Zxf5tC5LDH7lBbdaThfiT1TA520yuf6L6?=
 =?us-ascii?Q?e2i7M+Mv9vZT8x0rm7O4I95uw5BfEGXndae9LbB3eiwnxi6f2FkiiMQ69DCc?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <551B7A415A15A947974BEFA1C501419C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?E8RbYGje/fWDwmLL+LpIh+GW8zrj/WsuH023gvuV76Kyo3EnQ57YNmINAskt?=
 =?us-ascii?Q?D0e+9dUxVXmo0yboZF+V2ViB+ggc4iz3dZ3/K5ATlMwxMvjIow/Vad0rSL8n?=
 =?us-ascii?Q?rdeN+d0Citpk0uVP2TfqYLTUny+OhA8fF+r3hYUxGImy3u0x+Pz1Xg0NiC2I?=
 =?us-ascii?Q?qnL3xmrAJLPG7JZHfGheRFDUML8O5Bgm1H9yFjVdE6H5JO+IcqS5yPa1Kan7?=
 =?us-ascii?Q?b4haNBq0WXUL2Kp9SNkXdr3BQeqWEUdtmOg/JmarC6+5Dp7Dp+G3TPmtYzpF?=
 =?us-ascii?Q?ZBzhW3nv9u+0Sn4MqR4IxluhEtzN7s+7iMLubqBib+2mTLrztw4lsJ2yQcvb?=
 =?us-ascii?Q?wOCsM0ue2GG44iNzwiH+mmo8SOfRNVULUN937jE/HZDTSqAQ+iM3tF7F3QVF?=
 =?us-ascii?Q?Oi5wCuAFlKQMmbjpJqoq4B/wR4Jtdt76xSK0dKacZzfQSIIRRgqpd8ILN3Sr?=
 =?us-ascii?Q?WEDDTzJLOSZAntlzqRZ0+88eNbMRIMRpaOH7yjOC6B81X9viz3Z2pVAopX/c?=
 =?us-ascii?Q?MqbJOCgmRSZgPCU42arJZKSoBx3P8bXp4QAfIF23kzTZATS3iU6ZSmnJWNnW?=
 =?us-ascii?Q?2zUkUuL0qMHZvfpA2qnqYoHKMDfDz925Zc/iLziA4VggBERMobDqjIOX5QH1?=
 =?us-ascii?Q?cClb9oEhudG87Xv7UtlFclBsvohNRsJe8a/urY6aR88lDi9xTcT0nxvKLvW9?=
 =?us-ascii?Q?crDmrHFlsTVpZrT+VgoxvcDpraFxcA2VesiSkjtTqqhiJ5Dx83EaEoCRRtiW?=
 =?us-ascii?Q?KArjbYaMNXVTfTWsWuDUPD36SN6tFLI0EJMYBK8EjENKLKegE+1MNiOCqvUk?=
 =?us-ascii?Q?2pIMtB4lo8reEDMtnAlWvsg9OrYwzO7vFcU5u4c/wF6zho5v5AqwRdet2ic8?=
 =?us-ascii?Q?KXXlQxRA9j0jsdKq0X5ciGAx0BMM6llIsyPC2cZTLiYTLqFMzpFB5nfUnh1f?=
 =?us-ascii?Q?9ijbZ7534Qxqn67rq9IndwjJgUxFIN5vf6uPQ+CKDYIIXjVm5enrxFXw2Z3O?=
 =?us-ascii?Q?AJhSoy/GbOeFzserG6gGMqjeCAbfQNzdg1Y5RaBk9KT809i6CRqSzwGE9Q0f?=
 =?us-ascii?Q?nZDl3leR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d947b241-6bc9-48d3-ed73-08da81f60d66
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 15:18:21.2977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIgJQYZMvsmwyXw8It+sFpTcWuV4UIV83LCeOv2fhPdoE/LetmHV0oc59C4yEDol9SmxSLAmBa5s4k4whjPlsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190055
X-Proofpoint-ORIG-GUID: stvsd2FGfAHFBv6LMe6GPqRIaQ-5c4Ol
X-Proofpoint-GUID: stvsd2FGfAHFBv6LMe6GPqRIaQ-5c4Ol
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 18, 2022, at 2:31 PM, Anna Schumaker <anna@kernel.org> wrote:
>=20
> Assuming nobody else has started working on the sparse-read function,
> I would like to check my understanding of what it would look like:
>=20
> - The function splice_directo_to_actor() takes a "struct splice_desc"
> as an argument. The sparse read function would take something similar,
> a "struct sparse_desc", which has callbacks used by the underlying
> filesystem to tell the server to encode either a hole or data segment
> next.
>=20
> In the default case, the VFS tells the server to encode the entire
> read range as data. If underlying filesystems opt-in, then whenever a
> data extent is found the encode_data_segment() function is called and
> whenever a hole is found it calls the encode_hole_segment() function.
>=20
> The NFS server would need to know file offset and length of each
> segment, so these would probably be arguments to both functions. How
> would reading data work, though? The server needs to reserve space in
> the xdr stream for the offset & length metadata, but also the data
> itself. I'm assuming it would do something similar to
> fs/nfsd/vfs.c:nfsd_readv() and set up an iov_iter or kvec that the
> underlying filesystem can use to place file data?
>=20
> Does that sound about right? Am I missing anything?

I was expecting something more like what Dave originally described:

>> IOWs, it seems to me that what READ_PLUS really wants is a "sparse
>> read operation" from the filesystem rather than the current "read
>> that fills holes with zeroes". i.e. a read operation that sets an
>> iocb flag like RWF_SPARSE_READ to tell the filesystem to trim the
>> read to just the ranges that contain data.
>>=20
>> That way the read populates the page cache over a single contiguous
>> range of data and returns with the {offset, len} that spans the
>> range that is read and mapped. The caller can then read that region
>> out of the page cache and mark all the non-data regions as holes in
>> whatever manner they need to.
>>=20
>> The iomap infrastructure that XFS and other filesystems use provide
>> this exact "map only what contains data" capability - an iomap tells
>> the page cache exactly what underlies the data range (hole, data,
>> unwritten extents, etc) in an efficient manner, so it wouldn't be a
>> huge stretch just to limit read IO ranges to those that contain only
>> DATA extents.
>>=20
>> At this point READ_PLUS then just needs to iterate doing sparse
>> reads and recording the ranges that return data as vector of some
>> kind that is then passes to the encoding function to encode it as
>> a sparse READ_PLUS data range....


But it's not clear how this would be made atomic, so maybe the
callback mechanism you described is necessary.

To make some progress on moving READ_PLUS out of EXPERIMENTAL
status, can you build a READ_PLUS implementation that always
returns a single CONTENT_DATA segment? We can merge that straight
away, and it should perform on par with READ immediately.

Then the bells and whistles can be added over time.


--
Chuck Lever



