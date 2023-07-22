Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07C675DE8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jul 2023 22:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGVUeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Jul 2023 16:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGVUeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:34:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DD8E6E
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jul 2023 13:34:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36MKTMsP017668;
        Sat, 22 Jul 2023 20:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Wp0n58yvdp/7Kn+sQ4AkPJADAS90UefiBu/wihfsdHE=;
 b=IkH6LndlAtN69cCKVrL5LreIxd6BZoxxsekbCFs9ieskmzGSpeGX9khNMGeRfPFzYR9j
 wcOxc3p1IzOEHOO3hFg0BXT4sDWtcXizpv/cdzrxtSvU4aEAcgtucFTUMMKsj2UkUW+n
 EgqyCICMeG5d/IZSagKT0Ih6QNa0RZoN5WjZv3c8rg1C3i67LreeepvvTkXtnctqUgQJ
 BYXR7fYApkK8EYBokroCXP2GLXYJcgHKnysaV7CQmLYhA3+KQmT3FwFVFM5/wXkCm7OW
 tE3I7Ujfl0qVvnLRvYz4DNgfW9TH1plLstuDm+C8epRgogFX/ysW/xzMoAzVNAnLMThM pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05hdrqee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 20:33:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36MIucDN028655;
        Sat, 22 Jul 2023 20:33:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j2aebv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 20:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwH9McxK/xVYBABojdjtDdOza7naoZ9+CHusy4BKyEyorWqG9IzexAzJQ3+ZrWgVyRoNpMchxbgoCrV3zOLoJKZXiUMNH6EAw9kl4mVgkrdUPqN6LdzgdAj4J+3nKZqDsfrWUz48KKzRPdYAdV9A8b7GqyUyjFZUISvuZVXHeqTfRl5eeltIHR3aGVEN6Hpj6Od8ubIByjpSHutdHGPRfDMZXhFmQIfxC1DD1UbV4t5iXA3ykBuYtm/1qMsKhpSwjLMzpscNYbSXtX99kBPHjlsguomDlW6R3Xd+tmv0EsJdP7bdvFRDoHhVX2OvFcmJD80hgPrC9MUOvQ0j1RXElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp0n58yvdp/7Kn+sQ4AkPJADAS90UefiBu/wihfsdHE=;
 b=d68EwPV+r7BHUzDY5rihodCTzjU5dW5LF+mikeZjnIjXYw6sl58dEjPNzZq4mnhv8cRpxaVlVrjNkYg1wKfavTQQfSvaDFIC0Ao37zCWMLDcm26xKd4WylnATLlMP5946hRq1VuCl3Ss1PX2b2YbhJ/UmGEsxuh5xboH3BhB1MG6q+CNolxPt6gGm8k5edXOGppghu2Ad73+HpIaP8AMUsFrGWMiZLfMVfYhn4ebg31DQEI4fU1wEhRGn6hFD5zlwNq0YgnUlMZuYBNTwejfK9I2Ks31r3Z8UfNySKZeezHPcdrLjETuAHoOgUzLXZYMBLr+0fR8sq9iwIAuXFmj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp0n58yvdp/7Kn+sQ4AkPJADAS90UefiBu/wihfsdHE=;
 b=yWOL5wJMD95UHrwzxfLydu67pR6WAXZgDkncorOWcjFS8LAdv331sQtsqp+6t+79UjnsZXMSckH2wGw5hwrn19pEpDJOENeP1159LfdjnhjH1jJygWT47nl1FUcE+7NrftYQIrpfAh/9IaH9jqgUA29sMuWeYK+RbhdDXSA2Akc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7800.namprd10.prod.outlook.com (2603:10b6:408:1f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 20:33:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.031; Sat, 22 Jul 2023
 20:33:33 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Chuck Lever <cel@kernel.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] shmem: stable directory offsets
Thread-Topic: [PATCH v7 3/3] shmem: stable directory offsets
Thread-Index: AQHZq3ssrh2qup7PxEOYTribWI6Yka+9nbyAgAjC0oA=
Date:   Sat, 22 Jul 2023 20:33:33 +0000
Message-ID: <3B736492-9332-40C9-A916-DA6EE1A425B9@oracle.com>
References: <202307171436.29248fcf-oliver.sang@intel.com>
In-Reply-To: <202307171436.29248fcf-oliver.sang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|LV8PR10MB7800:EE_
x-ms-office365-filtering-correlation-id: ae4d3f87-9f12-403d-a308-08db8af2eb66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tuUs2fAqu4aNnq/4Nb0pLI0iHvOAitdUui1Uu2hQm8af/zGiIDSr9BePe/OPXA6wV6yS1/x2sX8dKjOf0VaH52YcRYRwQCbDBmukAYQyv0fk1C7psHn8cVr3b92QBC8kcjvxtmx34wdK/l6rwAmFrUPfD2Aa/sQg5W7j/VrJCQsLWi4DWhTIJpD2WDb+I+aR+3IiQuQoPRDpeWbN8vNM/8BsqByJ3VzdEt7oaSLpME075pl5bColNo1QSnsP7GMv7IEV9xw9MVWjbHqPURscIq06GA/XXAcndXGnjT//oyX4F7iHiVHCb1/afhia/ABlpmm/t1dG5Hn67VHH66TCYgs5/yEZio/MhOuEvgjlHbO5AUeS4+XzaUAUAxZgJM5GcpQqWQChrTGSDGl4WwcUaDdB7MeyzOhNBQYM35VBtRQG4n436UPzlhyu/dmGsTtlPFjdH7gWCjWELyjO5XtpiHSdaanGJ/bjHgkQuXYzFIx3GU/OkfTDb0JtSq//J6MuiGjLt7nm52nh35AzGibBOxH8DnO1Zl2lap9/xTQjWuysf7o+IbSG5lfONwX60GHRX4id7V8p1C7qU+56sFENeu9lV6qSG48euKNZScFZ4VW4FCbGWrC+Z2o4gowEzJfBMbUutfrYlNG8AU4zkI7H8vg6Q/WMqWH50pGdQguLXuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(71200400001)(6512007)(966005)(6486002)(19627235002)(91956017)(478600001)(54906003)(186003)(2616005)(53546011)(6506007)(26005)(30864003)(2906002)(316002)(41300700001)(76116006)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(7416002)(5660300002)(8676002)(8936002)(66946007)(38100700002)(122000001)(33656002)(36756003)(38070700005)(86362001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zL/AGOHRX4Vab6A24edpfILPvx8KXcudnOX99YeyTzoq9xvR5gXMGHFLL+VC?=
 =?us-ascii?Q?a8FNdqc4YdQCdwuN7FeEuAXf8QrLyQD1oRcmIaKNMa48Jlkgog02LnzHvtjw?=
 =?us-ascii?Q?e0NrveLRWbAsa4ts5zU9m+DcY9wUvX6CgTmDoVDAQhWPOcuvahcxJnZoDYuG?=
 =?us-ascii?Q?3C3fqb8Pc4ZiUfFV4DGhFst5I2zJjmWXSSubErJY7F5Wg74lH7ZrTMxd+pQA?=
 =?us-ascii?Q?aJPY/JAofjeZlh+s0OHI9ZPmVa8HU0TcSl/b5f9PJoAmP1pjEdDgZLasmx1D?=
 =?us-ascii?Q?882LzVSwPRcs8Il8imiqElEIZwqG3z6p+TtYfDagLxsLRA0q4W39+vgnVi1l?=
 =?us-ascii?Q?se394/Eey/gIDW4Tf0FFJ/154gmLQl7xOaUsTxPAJlO3+3d2smXNwF7emAAQ?=
 =?us-ascii?Q?nSfgUUmU/ji77IggaScb6Kl+6pnpOFTcFIr1dknfM3bECnTp5P4rMuJpMrr8?=
 =?us-ascii?Q?VIVza1RN7WzrEhHzSp57stZp62UKsCboaur4qsiOiDOJWHm0D7HyFDRAoNSE?=
 =?us-ascii?Q?+X9BxMQRfsCJalgRzH8TTAp+uA06Hc3ZhurJouY+qz0WGr1xxDwnGn7zYS62?=
 =?us-ascii?Q?iJL0OuACygLHIe+X2MNJjbs4O0r5HBTjZtD4jHsLjHuN6wX6IDL4+gm1in5s?=
 =?us-ascii?Q?ZWnJ0QprajCwtxw7zS6e0k0zVcCe+ucMELCMs85+zdzK8MjkC1haMv/XmIHt?=
 =?us-ascii?Q?NzTOppHBG6Y/3vsfYxPHMuEy1dv6Ts1raSoMqWOHfuZv/KYP1vdvovjD3qV6?=
 =?us-ascii?Q?CGTJVonkfpeRpsTnZPPKwVd1JzPIiiEt8C2bJKp5ruaGCtYOtn16EGa0/AvW?=
 =?us-ascii?Q?JDEcLUCHIc1776J6RtFfn/ncBd5Ve5DTGq66GB0urvA19M0KuSPfcpHuEHqi?=
 =?us-ascii?Q?H2CgH+CtQMeVxLVC059kmrdYW/l/rIYsG0lmXsn9gN8u8sACuiAsD5dXEWQH?=
 =?us-ascii?Q?QfOHFg7xL9ZyXDWCcHH4LJXzFkOgmLoZLbX8UiPFu5e8gsURdt8R7UP5IwmB?=
 =?us-ascii?Q?8u+iWTW1mtYlI9HA2nI8PEP9mgs1EdnBwR/kmKp7Ncn/+3UDLBAblDJadP6Z?=
 =?us-ascii?Q?0YeLU2u7qXwBZL3jzab043ZcH7nBgy+ktp0LpdZuKubMuXmOV03kRojz4TbG?=
 =?us-ascii?Q?VrNeNiqX8yrBpasF+T5J/ic62aQu6puIEe7GwWaqB4p8OInb6aEvIzwGZASL?=
 =?us-ascii?Q?xEdvvsnO+ytYBV0bWUypFgA4/GdG9v8+DNYRWqOXtNTiJysh7D5QIIhdoH8I?=
 =?us-ascii?Q?fAOtrKOno5fAWNR6su87rcLSrASH8dI+E6TMS0JUsKeCndVR+fobr1AoYNgz?=
 =?us-ascii?Q?1G9AlvCW3YeZV7izujnltTACdELv0cFYCJ2Tkm9E0g8XN8dPqKS36OfaNbDi?=
 =?us-ascii?Q?Wqm079gyxh8D0CxqJOCCVLY7cMUuh6PtdswGbvYWfQBqBwyBazG/HvfIG4gO?=
 =?us-ascii?Q?0ENQl1V8zu6+3dYNGfMMF1/neQJ6RIEGdPBzHUmJFuRhwtsDUTZ7D9Hdmkbr?=
 =?us-ascii?Q?whkFHd/C3rYAfSpKGdLJvaPQnOBAvbw0K31+hXKpr7H+i31ljxgsLuw9L6nb?=
 =?us-ascii?Q?OteY46kXiVj1fDnz06nA04dEjwTrE6qnDh/ZF9PfCoYnjjIWpBvYRdf3vdlm?=
 =?us-ascii?Q?vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF904F5078CDA540B4AC8A307B6F9B35@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dxoYsXzyxb87n/vDf8Ysj+Cfl3RfbqxgRxflL3e3s+EY5lAneGZy0Yco4Ygc?=
 =?us-ascii?Q?OUVleuQeT0gnm23XnfTvwSCXoiesnHB5VGbjTpDGsgQJB3yAioO9tiR4/E5R?=
 =?us-ascii?Q?lS4EkQOn7iYBm+nW2ZAwS+1JlvlH0JXf6P5oeOpgylqj94rw+OvKQk2HRHfj?=
 =?us-ascii?Q?vnfCiGHyIfkJrkRUFLFPjWzVqO5ZV+6oS/FVwnRliKWNHWWZ+Y7+7/C3zk6O?=
 =?us-ascii?Q?vmzQ+gR3qP93zWrE6Da7N5DkClPwytdHmRM/loUBWxpT/cNOJS/i55yI2QvZ?=
 =?us-ascii?Q?zpQZTma3J3q7TEjambnlmMZZt08kGInAMy0K+KtDi7X9WzIcd93nT7GK9QpT?=
 =?us-ascii?Q?pVlHJ0ACLF8EKE3zOUiRl4ZoZuILZwvZZnV+EzMdIlppcLDeeaSzunsC1POU?=
 =?us-ascii?Q?PR+bePbEDJDGoDHjJOW391yWUK1nrIEhRJjhLyGjaqfzh3kU0w1JsEmeLqSi?=
 =?us-ascii?Q?wcAWE7IK/7P7VYW9/koHfq0Rcuw0gbB9vK9c9PLa52x6pJ2PA340pf2KkVw2?=
 =?us-ascii?Q?upoC3+g3mS9x4PaoDAUX5wlo9tj2BFSSr4f/ElMblOU60HS30e6ZI64l1FQw?=
 =?us-ascii?Q?b+zEe4OgkVcd/rHfcTZr6/UJuZj2n5fZMlOWXbk7M0imB52hCwDVYRHdANk7?=
 =?us-ascii?Q?RrAc2b/EHMLSo8dvCfi0+Feu3Ic2SC01OcCKYzlff+4biTgBfutAL8lTYBvS?=
 =?us-ascii?Q?ALW1NLJbTTIknPFAYiGzJVNt50H4PZNXtj7SwkM8JS/dG9ao7K6voHv70Wvf?=
 =?us-ascii?Q?tsKY7cD80+tclW81JMsJuTpXifSda/EggOYwp6kjgsa2tp05k3jN/c8/vUJw?=
 =?us-ascii?Q?kIsetA2i+LYVcem+riRUFaQOap99KLP45StFnfEHBF2CLWEsrjMmuudC4GZQ?=
 =?us-ascii?Q?Y53MmiMIbPliL9cBxi+oIYtTceYtd555cOZh5890Bj3nF5ctuSuAjCa/xpF0?=
 =?us-ascii?Q?JMjd4m0cvEH/jhZMAXj5eZGgI6l47JFoSFRLivZTwoD2F72cx95h3seS76nJ?=
 =?us-ascii?Q?HMxt/1vHUONSk8fP/pOJm36OBmDB26Qn5MZAQFlJ7Zw/q4E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4d3f87-9f12-403d-a308-08db8af2eb66
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 20:33:33.8570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfX/z1keEKuahDIAzANz+GIMCRgfpvw1/eAJPwrqb26uvsG7UjkkGxhSUhSDJ/HLXyR+5GcML66uESsis7QAUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307220189
X-Proofpoint-ORIG-GUID: gQ6CBrtYe8nvEcyQixOpX_n5R29NdnIJ
X-Proofpoint-GUID: gQ6CBrtYe8nvEcyQixOpX_n5R29NdnIJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 17, 2023, at 2:46 AM, kernel test robot <oliver.sang@intel.com> wr=
ote:
>=20
>=20
> hi, Chuck Lever,
>=20
> we reported a 3.0% improvement of stress-ng.handle.ops_per_sec for this c=
ommit
> on
> https://lore.kernel.org/oe-lkp/202307132153.a52cdb2d-oliver.sang@intel.co=
m/
>=20
> but now we noticed a regression, detail as below, FYI
>=20
> Hello,
>=20
> kernel test robot noticed a -15.5% regression of will-it-scale.per_thread=
_ops on:
>=20
>=20
> commit: a1a690e009744e4526526b2f838beec5ef9233cc ("[PATCH v7 3/3] shmem: =
stable directory offsets")
> url: https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/libfs-Add=
-directory-operations-for-stable-offsets/20230701-014925
> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everyth=
ing
> patch link: https://lore.kernel.org/all/168814734331.530310.3911190551060=
453102.stgit@manet.1015granger.net/
> patch subject: [PATCH v7 3/3] shmem: stable directory offsets
>=20
> testcase: will-it-scale
> test machine: 104 threads 2 sockets (Skylake) with 192G memory
> parameters:
>=20
> nr_task: 16
> mode: thread
> test: unlink2
> cpufreq_governor: performance
>=20
>=20
> In addition to that, the commit also has significant impact on the follow=
ing tests:
>=20
> +------------------+-----------------------------------------------------=
--------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -40.0% r=
egression                                   |
> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CP=
U @ 3.00GHz (Cascade Lake) with 128G memory |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                              |
> |                  | mode=3Dthread                                       =
                                              |
> |                  | nr_task=3D16                                        =
                                              |
> |                  | test=3Dunlink2                                      =
                                              |
> +------------------+-----------------------------------------------------=
--------------------------------------------+
> | testcase: change | stress-ng: stress-ng.handle.ops_per_sec 3.0% improve=
ment                                        |
> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU=
 @ 3.00GHz (Skylake) with 32G memory        |
> | test parameters  | class=3Dfilesystem                                  =
                                              |
> |                  | cpufreq_governor=3Dperformance                      =
                                              |
> |                  | disk=3D1SSD                                         =
                                              |
> |                  | fs=3Dext4                                           =
                                              |
> |                  | nr_threads=3D10%                                    =
                                              |
> |                  | test=3Dhandle                                       =
                                              |
> |                  | testtime=3D60s                                      =
                                              |
> +------------------+-----------------------------------------------------=
--------------------------------------------+
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202307171436.29248fcf-oliver.san=
g@intel.com
>=20
>=20
> Details are as below:
> -------------------------------------------------------------------------=
------------------------->
>=20
>=20
> To reproduce:
>=20
>        git clone https://github.com/intel/lkp-tests.git
>        cd lkp-tests
>        sudo bin/lkp install job.yaml           # job file is attached in =
this email

I'm trying to reproduce the regression here, but the reproducer fails
at this step with:

=3D=3D> Installing package will-it-scale with /export/xfs/lkp-tests/sbin/pa=
cman-LKP -U...
warning: source_date_epoch_from_changelog set but %changelog is missing
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.Py4eQi
+ umask 022
+ cd /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILD
+ '[' /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/=
will-it-scale-LKP-1-1.x86_64 '!=3D' / ']'
+ rm -rf /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDRO=
OT/will-it-scale-LKP-1-1.x86_64
++ dirname /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILD=
ROOT/will-it-scale-LKP-1-1.x86_64
+ mkdir -p /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILD=
ROOT
+ mkdir /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROO=
T/will-it-scale-LKP-1-1.x86_64
+ CFLAGS=3D'-march=3Dx86-64 -mtune=3Dgeneric -O2 -pipe -fstack-protector-st=
rong --param=3Dssp-buffer-size=3D4'
+ export CFLAGS
+ CXXFLAGS=3D'-march=3Dx86-64 -mtune=3Dgeneric -O2 -pipe -fstack-protector-=
strong --param=3Dssp-buffer-size=3D4'
+ export CXXFLAGS
+ FFLAGS=3D'-O2 -flto=3Dauto -ffat-lto-objects -fexceptions -g -grecord-gcc=
-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -=
Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -=
fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1  -m=
64  -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection =
-fcf-protection -I/usr/lib64/gfortran/modules'
+ export FFLAGS
+ FCFLAGS=3D'-O2 -flto=3Dauto -ffat-lto-objects -fexceptions -g -grecord-gc=
c-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 =
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 =
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1  -=
m64  -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection=
 -fcf-protection -I/usr/lib64/gfortran/modules'
+ export FCFLAGS
+ LDFLAGS=3D-Wl,-O1,--sort-common,--as-needed,-z,relro
+ export LDFLAGS
+ LT_SYS_LIBRARY_PATH=3D/usr/lib64:
+ export LT_SYS_LIBRARY_PATH
+ CC=3Dgcc
+ export CC
+ CXX=3Dg++
+ export CXX
+ cp -a /export/xfs/lkp-tests/programs/will-it-scale/pkg/will-it-scale-lkp/=
lkp /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/wi=
ll-it-scale-LKP-1-1.x86_64
+ /usr/lib/rpm/check-buildroot
+ /usr/lib/rpm/redhat/brp-ldconfig
+ /usr/lib/rpm/brp-compress
+ /usr/lib/rpm/brp-strip /usr/bin/strip
+ /usr/lib/rpm/brp-strip-comment-note /usr/bin/strip /usr/bin/objdump
/usr/bin/objdump: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_bui=
ld/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/writ=
eseek2/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/=
will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/dup1_threads': No=
 such file
/usr/bin/strip: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build=
/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/writes=
eek2/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/wi=
ll-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/dup1_threads': No s=
uch file
/usr/bin/objdump: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_bui=
ld/BUILDROOT/will-it-scale-LKP-1-1.x8/export/xfs/lkp-tests/programs/will-it=
-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/=
will-it-scale/brk1_processes': No such file
/usr/bin/strip: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build=
/BUILDROOT/will-it-scale-LKP-1-1.x8/export/xfs/lkp-tests/programs/will-it-s=
cale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/wi=
ll-it-scale/brk1_processes': No such file
/usr/bin/objdump: '/export/xfs/lkp-tests/programs/will-it-sc_processes': No=
 such file
/usr/bin/strip: '/export/xfs/lkp-tests/programs/will-it-sc_processes': No s=
uch file
/usr/bin/objdump: '6_64/lkp/benchmarks/will-it-scale/pread2_threads': No su=
ch file
/usr/bin/strip: '6_64/lkp/benchmarks/will-it-scale/pread2_threads': No such=
 file
/usr/bin/objdump: 'ale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64=
/lkp/benchmarks/will-it-scale/poll2_processes': No such file
/usr/bin/strip: 'ale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/l=
kp/benchmarks/will-it-scale/poll2_processes': No such file
+ /usr/lib/rpm/redhat/brp-strip-lto /usr/bin/strip
+ /usr/lib/rpm/brp-strip-static-archive /usr/bin/strip
+ /usr/lib/rpm/check-rpaths
+ /usr/lib/rpm/redhat/brp-mangle-shebangs
mangling shebang in /lkp/benchmarks/python3/bin/python3.8-config from /bin/=
sh to #!/usr/bin/sh
*** ERROR: ambiguous python shebang in /lkp/benchmarks/python3/lib/python3.=
8/encodings/rot_13.py: #!/usr/bin/env python. Change it to python3 (or pyth=
on2) explicitly.
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/lib2to3/pgen2/tok=
en.py from /usr/bin/env python3 to #!/usr/bin/python3
*** ERROR: ambiguous python shebang in /lkp/benchmarks/python3/lib/python3.=
8/lib2to3/tests/data/different_encoding.py: #!/usr/bin/env python. Change i=
t to python3 (or python2) explicitly.
*** ERROR: ambiguous python shebang in /lkp/benchmarks/python3/lib/python3.=
8/lib2to3/tests/data/false_encoding.py: #!/usr/bin/env python. Change it to=
 python3 (or python2) explicitly.
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/lib2to3/tests/pyt=
ree_idempotency.py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/config-3.8-x86_64=
-linux-gnu/makesetup from /bin/sh to #!/usr/bin/sh
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/config-3.8-x86_64=
-linux-gnu/install-sh from /bin/sh to #!/usr/bin/sh
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/ctypes/macholib/f=
etch_macholib from /bin/sh to #!/usr/bin/sh
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/bytede=
sign.py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/clock.=
py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/forest=
.py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/fracta=
lcurves.py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/linden=
mayer.py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/minima=
l_hanoi.py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/paint.=
py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/peace.=
py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/penros=
e.py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/planet=
_and_moon.py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/tree.p=
y from /usr/bin/env python3 to #!/usr/bin/python3
*** WARNING: ./lkp/benchmarks/python3/lib/python3.8/turtledemo/two_canvases=
.py is executable but has no shebang, removing executable bit
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/yinyan=
g.py from /usr/bin/env python3 to #!/usr/bin/python3
*** WARNING: ./lkp/benchmarks/python3/lib/python3.8/idlelib/idle.bat is exe=
cutable but has no shebang, removing executable bit
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/idlelib/pyshell.p=
y from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/ziptestdata/=
exe_with_z64 from /bin/bash to #!/usr/bin/bash
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/ziptestdata/=
exe_with_zip from /bin/bash to #!/usr/bin/bash
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/ziptestdata/=
header.sh from /bin/bash to #!/usr/bin/bash
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/bisect_cmd.p=
y from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/curses_tests=
.py from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/regrtest.py =
from /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/re_tests.py =
from /usr/bin/env python3 to #!/usr/bin/python3
*** WARNING: ./lkp/benchmarks/python3/lib/python3.8/test/test_dataclasses.p=
y is executable but has no shebang, removing executable bit
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/base64.py from /u=
sr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/cProfile.py from =
/usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/pdb.py from /usr/=
bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/platform.py from =
/usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/profile.py from /=
usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/quopri.py from /u=
sr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/smtpd.py from /us=
r/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/smtplib.py from /=
usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/tabnanny.py from =
/usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/tarfile.py from /=
usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/timeit.py from /u=
sr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/trace.py from /us=
r/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/uu.py from /usr/b=
in/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/python3/lib/python3.8/webbrowser.py fro=
m /usr/bin/env python3 to #!/usr/bin/python3
mangling shebang in /lkp/benchmarks/will-it-scale/runalltests from /bin/sh =
to #!/usr/bin/sh
error: Bad exit status from /var/tmp/rpm-tmp.Py4eQi (%install)

RPM build warnings:
    source_date_epoch_from_changelog set but %changelog is missing

RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.Py4eQi (%install)
error: open of /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/R=
PMS/will-it-scale-LKP.rpm failed: No such file or directory
=3D=3D> WARNING: Failed to install built package(s).
[cel@manet lkp-tests]$

I'm on Fedora 38 x86_64.


--
Chuck Lever


