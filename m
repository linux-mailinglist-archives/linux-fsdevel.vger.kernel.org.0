Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DDE703FE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 23:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjEOVhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 17:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245524AbjEOVhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 17:37:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40324869A;
        Mon, 15 May 2023 14:37:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJrvZ1002999;
        Mon, 15 May 2023 21:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9+OrqV1LQKTxDXxfciBjSfV5ocEDtMgC+PjzGgd5Xm0=;
 b=z2csDBsHbODNbFqTGgcZ811pmw6U27GSuuUReIlCCu/sM2OpzLp9M8eC6mgry6cjL7uz
 QMSaRRo4nM3pza2+8jjQjFIRd3wX8wRu4MCMTEFF7NEDrcef4nXO36mwtQtpyPjwvm0j
 3ixdM6ejinQqPzw60e0lEIkSrJlWShfhzreie18+8cijWRa73sWf+u3VkyMLkwHHFizH
 yMWNkIl4cH/sBv5ui+zP5F+rR3g6rfs8aOf/VcoxBPCIIsPwudAn/cBjh5kL7abnpZe2
 7P83XQnAmqpL2vtUcSwvxBMEzDmj9+iAhCJOKLsfm51JmpksAloQv9/paOzFNQTl697x VA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdhdnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 21:37:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FKGhde036752;
        Mon, 15 May 2023 21:37:36 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj109ga8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 21:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzb8FRDoG94zlkiE1hBl38WqB0cFP0jbRJx3W8Lb6EibO+cFykOIyNl0Icews+Dm0QHoBV5WlHZ0uYMSeQ9REZjShjiqCt9VE8gRU+4jOmNWpuhqAei2DmqFklNPBsVTciP4PVc39NHsMtqBuzAYmmSPcJtiZEvF3DPluaI/PX7T2DEB1BSl7IDZaIUy5rhXqIc1fLnhNkK/mhX62KOSMGmbeodWhsRaHADUkmqoaPIoO6npGlfIqklZCOh/7WrY97ZMA+lM0ER/vHy8oEx6Lyck3yE6bvIXJtRHnaHrNW0+KM+/Bzb4bXBBCYMF+ihIXd1oET6M5W50RINv8KBC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+OrqV1LQKTxDXxfciBjSfV5ocEDtMgC+PjzGgd5Xm0=;
 b=IHfmux1lo1YMcgjnSO+9qkd25Ro5c2IQ6tP7h7f/WbC5yXItG8AWH8bVmiJd///klh8XXC2Lz9QKVVrWbTpo5Qf4sdQCyR1af0Om70DJ4r9FFHTuOzzlYqe1lGLjHLduBL2aIIrYuMRVH5IhRPJREGo2Nw/Vq0ZmkVD5T6YF42bKKmG/24xtosEPgLjJV+NLdfimFyq9mf4MM12kZQzIrC0SrH95PX37tihQnQsiwtKMVGDiVSTHRWkZ+V6xHQCUH0paTb6jZDz96sRHbJDwDFY96whk15st+VyNigxsf/HU7sZJ71HGaQwZC06/WDls7pSMrN4hXOsRed9o/o+Zqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+OrqV1LQKTxDXxfciBjSfV5ocEDtMgC+PjzGgd5Xm0=;
 b=LlmiCw37GwYaMQJu6lJR3r1yag0hKewcvYJu5zRO+dBVyCuJocMXJCpCaPY6Dm4jc+6TYnxxGIocJ2cvpB5V2BLnn0v6Mbw3MrPFJGQ3vXPyv+kutFBwmyF1+DT9v/d+UHCLGSjl9IsH1rGkIgOwMV+anT7BlqAH/9djvy7TEgU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5227.namprd10.prod.outlook.com (2603:10b6:610:c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 21:37:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 21:37:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
Thread-Topic: [PATCH v2 4/4] NFSD: handle GETATTR conflict with write
 delegation
Thread-Index: AQHZhsMdl94xHU6uH0e1krYB7i5sMK9bpMSAgAADSgCAAAjFgIAAFC4AgAADRoCAABUPAA==
Date:   Mon, 15 May 2023 21:37:32 +0000
Message-ID: <17E187C9-60D6-4882-B928-E7826AA68F45@oracle.com>
References: <1684110038-11266-1-git-send-email-dai.ngo@oracle.com>
 <1684110038-11266-5-git-send-email-dai.ngo@oracle.com>
 <CAN-5tyH0GM8xOnLVDMQMn-tmoE-w_7N9ARmcwHq6ocySeoA1MQ@mail.gmail.com>
 <392379f7-4e28-fae5-a799-00b4e35fe6fd@oracle.com>
 <5318a050cbe6e89ae0949c654545ae8998ff7795.camel@kernel.org>
 <CAN-5tyFE3=DF+48SBGrC2u3y-MNr+1nM+xFM4CXaYv23AMZvew@mail.gmail.com>
 <30df13a02cbe9d7c72d0518c011e066e563bcbc8.camel@kernel.org>
In-Reply-To: <30df13a02cbe9d7c72d0518c011e066e563bcbc8.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5227:EE_
x-ms-office365-filtering-correlation-id: 21d621e2-24af-41b5-4e7f-08db558c9785
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: USGitfO0nUt7HB0vqZrtNhpCHuatFtu23xOIZMsYjQgLf7DEtDrbkVjnRRi2dc3mw3QwWgqLmPXdB/YR2M0hzYusqWDJVqqZd+4VIoUNrcDdcuLzNefQOlMZ2HVyNRuSx6CGX48ZIRrRE0dK7bVjA5bfAUbyo7CWf67tbgK2g5L9AyRT2mEPUhO6acE+Xj8M7XQLnjDG9JeRTVxThJyDnMbv1nEsytLxx+WDT+S93rTrROGvgxi2MLtQpb6I8adZtf4JhAEk5esEvWB9gW7I4qWqTUIOKcmGL6t5D1gCmPJpGd194s3FNyEL5lmZQ4l5wO88RTqkYnDL7c1OkTkMKoAaUjY5ibCQtCQ8NZHjzRPovneLn6ar6O1LtYN5mq4MrcmwpdPrn7lxBJPScTIMwc98Ej8esJHTKS/SKJ8DCieLKFmwjnektq5lQZ//1YmCj+3k5zxoZplCoVg6dMuYyfYNSwZDLgNoYdFfUWCcAq5cBgs55O55oJTDF9h02FHo1B8abPHsaQ4Qe44owkLolbJbT1vJZCnQwGZcwOjhgnoFguAe921/zMr1INyGxtIsuF8PG4T6ZuhYq5aBZ8nJwFfvA3j5lMexegcvoURTgt+oUpNGnalFhzJiTzwruHBrADPptDT119PEqFFBdKqTyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(66556008)(64756008)(66476007)(4326008)(66446008)(478600001)(76116006)(66946007)(110136005)(54906003)(91956017)(6506007)(53546011)(186003)(6512007)(38100700002)(38070700005)(83380400001)(2616005)(36756003)(8936002)(8676002)(2906002)(71200400001)(316002)(6486002)(33656002)(86362001)(122000001)(41300700001)(5660300002)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHliUStMRzRDTnZiTlJoeE5lNW10TDJ6Rjlwem5UcWlRdGpiMWZLcXZZblVB?=
 =?utf-8?B?Nzg4bzNISWpSQ1VseFR5b0xCSmRKemtzaUtmWC9sTjJhaDRPcVlDQTJ2eWpr?=
 =?utf-8?B?U1Z4TVVsRUpSL3VPUzVCVGxmNlZCTjVzUisvU0sxYWkzaFd6eVRIVEtTR0h1?=
 =?utf-8?B?citUcXdETG9nbUJZMDdPWGN3OEpxQ2JEZVU5WTRncFh0cVRET1ZJS1cva2FF?=
 =?utf-8?B?MFhXdVNSdHN4QkJoOFJ5ei9FQW9mU29uYzhvcmwrNEFkOFQxQ2VncHFRMGZI?=
 =?utf-8?B?bnc0amo5Z0xvSXVrNHFNTmhmYmh4MVZBeEhnN0gwNFJ0b0VpSFI2UlN6czZY?=
 =?utf-8?B?b2hVNEViRHNVVW5iMG01VTJpbUxCWWlMb3RBTU9QODZMMFdHSGJneGFtT2NS?=
 =?utf-8?B?L3VEU0ttVEhVbU54NUQ4QXI0R1ZnUWFjZlpqdzF5alIyaTNKbmE5bTBtYlBB?=
 =?utf-8?B?d2ZzSk9yRTJ1SHNDbUIwVFFkWE9rR2o2dnNkU3ZXNG1qazdsb3pCdGRMVE5S?=
 =?utf-8?B?OExOUWkrQ1dIaU5YY2pTTm5nQ3NxaGRsdzBaY2RnY2oydEtIYVdSSG95U3cz?=
 =?utf-8?B?dXY1NU5mRkR1aVhHU0VzUTFLOXZaTXRxKytKU21zYTZJNUVyNllNTTFSWnF3?=
 =?utf-8?B?ejJnVGhyQW1lSnR2MWF0OE1WV2ZhR2Z4REh1SE84ODBLSy9TRDF5MHRsOTNm?=
 =?utf-8?B?UUkwRmtCZWtXR05hcXpjazhIUktLYjV0ZW9tYkhsVS93MEd5VkFIQXZ6Q0FC?=
 =?utf-8?B?SHpYZVZvdGdobFFYSXBUNkJLSERzeitSQW13alRSRVBFdHFFRnhGcjNQd0lm?=
 =?utf-8?B?VXdzVnVEUDQ1dldRYkJ5QSt6TVYwNnZKMW53VGJVdVBtb2dYVFZyUUVPc3pE?=
 =?utf-8?B?YmdKN3ZLYXlaZFBMaDNldkd2bUNWVUQxbWtxT2pGUkdFK2MrVjkxMFhaeGNR?=
 =?utf-8?B?UnpIVGhjdmxPQmVOZkI4UGRsWGdnMXUxVGt3SU5wYlljdnNYWmx3K1ZPRHh4?=
 =?utf-8?B?NStRTTc0Vml5bUlwL1dIQzNiR2YxdzdIbGpMWmtuTnBMY0xGMFUxeVExUkhI?=
 =?utf-8?B?MjdqRjNCeFovS1ZvamVyWVB4b2thUC90MWppOUJCWVQrNFpIaFZGdkVwL1Zu?=
 =?utf-8?B?YXIvYnFxYVBpbCt1SmgyY3pBWGhVMWt5YTY0UWRxdGN0NGppUWllSWV2NFIw?=
 =?utf-8?B?K2xCYVdHUDJ1YVJLekJ5SmU3YjlVOEpvNXhiVGNrVmsrdmVQSksxS2hOUmNM?=
 =?utf-8?B?MjNsTlNzZ3RrTnREWU5mR3lEOERWNVpXR0dFWGVOajZ6NFRNM0NHTk95Qnlz?=
 =?utf-8?B?NGtodnJ6enk3MGplNUJmTTZzVUN2R2xIVSs2Qm1EeTVEeWxwcW1HR2JHWktr?=
 =?utf-8?B?dU5TeHlKMU9WclFRYWk1anliTnpBTGU2cU4wTTVFR1Iyd0xsZ3NzaTdkT3oz?=
 =?utf-8?B?OVA2UjZoUVF5WDVlN3ppTXNKcnVmbDY2endlc2FSOFNaSThmTGFHTklXcnBC?=
 =?utf-8?B?dDY3TlI5WHF4ekF3enRLUU11QlhENllIczVpMFRzS25haC93YkhEMzVzNDgy?=
 =?utf-8?B?SFdFU3BzN2xBbjJTVDQveDl6UWJOMTJxUFFNZlQvMWpad1U1R29KUlBHd2Uv?=
 =?utf-8?B?cmNqaHhFMnJCblQ1RFIxZXNpQjRkaUJBcjd2ZEFkcEtZY0RYQm12TkJ0ZWlD?=
 =?utf-8?B?SC9zeU9paXIxd3lOUWRNaWYzbjBJTlh3d3dHSzRpdmVBaHc1Zm9sT01Jd1JS?=
 =?utf-8?B?aFJvOEd2VkxEVHQ0MzFZdnZlaTRwUkR0QUFQUEFNbDdNR3NaOEFuTzBSNkNu?=
 =?utf-8?B?QlJxakQ0RUpPR2xMbjM2cmU0K3JWWkYrN0RzQWV0RFRETVFJUTNuaHI5eENv?=
 =?utf-8?B?ZjQxY0hoU3dTWEFQYktXM3A2Yi9nK1FSMklaRjJ3enhNNm1Yb0I2WU1UUDEy?=
 =?utf-8?B?WWwxK1d1Y25kNFpSSXJNSW1sbjlCK3d1OW4yUWZmaytLZEl4WVQzRC9kNnpP?=
 =?utf-8?B?V29tWWdtMWFDRUN0SkNJWGZCOXJQN1NyZ0lydEg2b1B2T3I0Wi9pL1A2WlRq?=
 =?utf-8?B?TXVoamNtdUQveCtZQUFCNU9YSHRXTy9QQUxDK2R5eENaUUZscEw1dDVORjdp?=
 =?utf-8?B?ZmgwUUtQa2wyWXZjWGRWOXdCeHdUY3JMa0Y0RzZkeGFoQjV1Rmc1UFJ1TFE3?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA1204E9A23C94469F3CDEA8EDE4280C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uFdjL2XWX6v0yAKsvH7sC6Z13arvgsTVl1yg9XOuoTRmTx82941zEW3coVvGirBMo+mAXa3ev1QDV+jyInnavE2yhz4HHgoXOfziMFoZnis0LPBV6xT9Lvjc5kqxDyzCQUIQevH+tCymcMGe2E2Y62PdKJOYrZy2W+P4DFe1cdwuMqoEzzINppht4kpTvl+pNWhRlPdTVKH3luqKDlCnRYz19g3stRn6cWk6hCHV9YkTS6nor2uuBaubM6nf2jH74NfohMS8jDK/Qiha1ewVwdoT9xM+i1nZ6Dteiqqt9kGfGbxaW1WWOS9JkGrflw+xgFas9sdB49YE0tljD3X0ioG4GTMeab0y6JF+Sq6NT/cWKvQqQ894IXBPo6DPgtIP835WLjQJ9zxdY9bvfHE7YBub2id+U55x4qRl+WUhNipswYR+5uCCp76uDh7Lg8N3KIDARxfbjpESCtpwMFhdC9upmKVXq3fsPnQ99UEQAL2XyAfmZCes7WI9mazoJpYdsk08oOKmyWRpVr+tHpOgnK1Mbo64/5JCYeMY4TBgiz3+rwvCjQhU3d+HBiR4qvHIG07U40slPsCmWclWnQQsakX+onOeJSjxU02yTiowtqVpuf9BMD8MA56LJ33aYvBPHYNY7MR850xtkBUZEJohGcx6pza3fRKcLnKTo82gA/kVba0YXCUdVvigSvtFv+D31nw0NKgdHWKTsv96cgJ4Y+2KUh8Ean+sin+AdR8c4Ugga3WWEozDNNyYBdrxmMEEnMgxCraOvRn+zYz/apPn+KvNbLqUo5f/hE3OZotgT6tdB9QOmNJvhvqNUQiw+Wg/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d621e2-24af-41b5-4e7f-08db558c9785
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 21:37:32.8334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYXssdoTfogzDQfrpWt/+QM9SLzWwB5sF1ZTvyHpbE9tc3Dhqma/tMDtiYrwTU8IokvPHdrRRPgvh4pGMwM8TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_19,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150178
X-Proofpoint-GUID: RcSMMlYpF04ekoLWxtzln1mfm4cQYs_d
X-Proofpoint-ORIG-GUID: RcSMMlYpF04ekoLWxtzln1mfm4cQYs_d
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gTWF5IDE1LCAyMDIzLCBhdCA0OjIxIFBNLCBKZWZmIExheXRvbiA8amxheXRvbkBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgMjAyMy0wNS0xNSBhdCAxNjoxMCAtMDQw
MCwgT2xnYSBLb3JuaWV2c2thaWEgd3JvdGU6DQo+PiBPbiBNb24sIE1heSAxNSwgMjAyMyBhdCAy
OjU44oCvUE0gSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gDQo+
Pj4gT24gTW9uLCAyMDIzLTA1LTE1IGF0IDExOjI2IC0wNzAwLCBkYWkubmdvQG9yYWNsZS5jb20g
d3JvdGU6DQo+Pj4+IE9uIDUvMTUvMjMgMTE6MTQgQU0sIE9sZ2EgS29ybmlldnNrYWlhIHdyb3Rl
Og0KPj4+Pj4gT24gU3VuLCBNYXkgMTQsIDIwMjMgYXQgODo1NuKAr1BNIERhaSBOZ28gPGRhaS5u
Z29Ab3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4+Pj4gSWYgdGhlIEdFVEFUVFIgcmVxdWVzdCBvbiBh
IGZpbGUgdGhhdCBoYXMgd3JpdGUgZGVsZWdhdGlvbiBpbiBlZmZlY3QNCj4+Pj4+PiBhbmQgdGhl
IHJlcXVlc3QgYXR0cmlidXRlcyBpbmNsdWRlIHRoZSBjaGFuZ2UgaW5mbyBhbmQgc2l6ZSBhdHRy
aWJ1dGUNCj4+Pj4+PiB0aGVuIHRoZSByZXF1ZXN0IGlzIGhhbmRsZWQgYXMgYmVsb3c6DQo+Pj4+
Pj4gDQo+Pj4+Pj4gU2VydmVyIHNlbmRzIENCX0dFVEFUVFIgdG8gY2xpZW50IHRvIGdldCB0aGUg
bGF0ZXN0IGNoYW5nZSBpbmZvIGFuZCBmaWxlDQo+Pj4+Pj4gc2l6ZS4gSWYgdGhlc2UgdmFsdWVz
IGFyZSB0aGUgc2FtZSBhcyB0aGUgc2VydmVyJ3MgY2FjaGVkIHZhbHVlcyB0aGVuDQo+Pj4+Pj4g
dGhlIEdFVEFUVFIgcHJvY2VlZHMgYXMgbm9ybWFsLg0KPj4+Pj4+IA0KPj4+Pj4+IElmIGVpdGhl
ciB0aGUgY2hhbmdlIGluZm8gb3IgZmlsZSBzaXplIGlzIGRpZmZlcmVudCBmcm9tIHRoZSBzZXJ2
ZXIncw0KPj4+Pj4+IGNhY2hlZCB2YWx1ZXMsIG9yIHRoZSBmaWxlIHdhcyBhbHJlYWR5IG1hcmtl
ZCBhcyBtb2RpZmllZCwgdGhlbjoNCj4+Pj4+PiANCj4+Pj4+PiAgICAuIHVwZGF0ZSB0aW1lX21v
ZGlmeSBhbmQgdGltZV9tZXRhZGF0YSBpbnRvIGZpbGUncyBtZXRhZGF0YQ0KPj4+Pj4+ICAgICAg
d2l0aCBjdXJyZW50IHRpbWUNCj4+Pj4+PiANCj4+Pj4+PiAgICAuIGVuY29kZSBHRVRBVFRSIGFz
IG5vcm1hbCBleGNlcHQgdGhlIGZpbGUgc2l6ZSBpcyBlbmNvZGVkIHdpdGgNCj4+Pj4+PiAgICAg
IHRoZSB2YWx1ZSByZXR1cm5lZCBmcm9tIENCX0dFVEFUVFINCj4+Pj4+PiANCj4+Pj4+PiAgICAu
IG1hcmsgdGhlIGZpbGUgYXMgbW9kaWZpZWQNCj4+Pj4+PiANCj4+Pj4+PiBJZiB0aGUgQ0JfR0VU
QVRUUiBmYWlscyBmb3IgYW55IHJlYXNvbnMsIHRoZSBkZWxlZ2F0aW9uIGlzIHJlY2FsbGVkDQo+
Pj4+Pj4gYW5kIE5GUzRFUlJfREVMQVkgaXMgcmV0dXJuZWQgZm9yIHRoZSBHRVRBVFRSLg0KPj4+
Pj4gSGkgRGFpLA0KPj4+Pj4gDQo+Pj4+PiBJJ20gY3VyaW91cyB3aGF0IGRvZXMgdGhlIHNlcnZl
ciBnYWluIGJ5IGltcGxlbWVudGluZyBoYW5kbGluZyBvZg0KPj4+Pj4gR0VUQVRUUiB3aXRoIGRl
bGVnYXRpb25zPyBBcyBmYXIgYXMgSSBjYW4gdGVsbCBpdCBpcyBub3Qgc3RyaWN0bHkNCj4+Pj4+
IHJlcXVpcmVkIGJ5IHRoZSBSRkMocykuIFdoZW4gdGhlIGZpbGUgaXMgYmVpbmcgd3JpdHRlbiBh
bnkgYXR0ZW1wdCBhdA0KPj4+Pj4gcXVlcnlpbmcgaXRzIGF0dHJpYnV0ZSBpcyBpbW1lZGlhdGVs
eSBzdGFsZS4NCj4+Pj4gDQo+Pj4+IFllcywgeW91J3JlIHJpZ2h0IHRoYXQgaGFuZGxpbmcgb2Yg
R0VUQVRUUiB3aXRoIGRlbGVnYXRpb25zIGlzIG5vdA0KPj4+PiByZXF1aXJlZCBieSB0aGUgc3Bl
Yy4gVGhlIG9ubHkgYmVuZWZpdCBJIHNlZSBpcyB0aGF0IHRoZSBzZXJ2ZXINCj4+Pj4gcHJvdmlk
ZXMgYSBtb3JlIGFjY3VyYXRlIHN0YXRlIG9mIHRoZSBmaWxlIGFzIHdoZXRoZXIgdGhlIGZpbGUg
aGFzDQo+Pj4+IGJlZW4gY2hhbmdlZC91cGRhdGVkIHNpbmNlIHRoZSBjbGllbnQncyBsYXN0IEdF
VEFUVFIuIFRoaXMgYWxsb3dzDQo+Pj4+IHRoZSBhcHAgb24gdGhlIGNsaWVudCB0byB0YWtlIGFw
cHJvcHJpYXRlIGFjdGlvbiAod2hhdGV2ZXIgdGhhdA0KPj4+PiBtaWdodCBiZSkgd2hlbiBzaGFy
aW5nIGZpbGVzIGFtb25nIG11bHRpcGxlIGNsaWVudHMuDQo+Pj4+IA0KPj4+IA0KPj4+IA0KPj4+
IA0KPj4+IEZyb20gUkZDIDg4ODEgMTAuNC4zOg0KPj4+IA0KPj4+ICJJdCBzaG91bGQgYmUgbm90
ZWQgdGhhdCB0aGUgc2VydmVyIGlzIHVuZGVyIG5vIG9ibGlnYXRpb24gdG8gdXNlDQo+Pj4gQ0Jf
R0VUQVRUUiwgYW5kIHRoZXJlZm9yZSB0aGUgc2VydmVyIE1BWSBzaW1wbHkgcmVjYWxsIHRoZSBk
ZWxlZ2F0aW9uIHRvDQo+Pj4gYXZvaWQgaXRzIHVzZS4iDQo+PiANCj4+IFRoaXMgaXMgYSAiTUFZ
IiB3aGljaCBtZWFucyB0aGUgc2VydmVyIGNhbiBjaG9vc2UgdG8gbm90IHRvIGFuZCBqdXN0DQo+
PiByZXR1cm4gdGhlIGluZm8gaXQgY3VycmVudGx5IGhhcyB3aXRob3V0IHJlY2FsbGluZyBhIGRl
bGVnYXRpb24uDQo+PiANCj4+IA0KPiANCj4gVGhhdCdzIG5vdCBhdCBhbGwgaG93IEkgcmVhZCB0
aGF0LiBUbyBtZSwgaXQgc291bmRzIGxpa2UgaXQncyBzYXlpbmcNCj4gdGhhdCB0aGUgb25seSBh
bHRlcm5hdGl2ZSB0byBpbXBsZW1lbnRpbmcgQ0JfR0VUQVRUUiBpcyB0byByZWNhbGwgdGhlDQo+
IGRlbGVnYXRpb24uIElmIHRoYXQncyBub3QgdGhlIGNhc2UsIHRoZW4gd2Ugc2hvdWxkIGNsYXJp
ZnkgdGhhdCBpbiB0aGUNCj4gc3BlYy4NCg0KVGhlIG1lYW5pbmcgb2YgTUFZIGlzIHNwZWxsZWQg
b3V0IGluIFJGQyAyMTE5LiBNQVkgZG9lcyBub3QgbWVhbg0KInRoZSBvbmx5IGFsdGVybmF0aXZl
Ii4gSSByZWFkIHRoaXMgc3RhdGVtZW50IGFzIGFsZXJ0aW5nIGNsaWVudA0KaW1wbGVtZW50ZXJz
IHRoYXQgYSBjb21wbGlhbnQgc2VydmVyIGlzIHBlcm1pdHRlZCB0byBza2lwDQpDQl9HRVRBVFRS
LCBzaW1wbHkgYnkgcmVjYWxsaW5nIHRoZSBkZWxlZ2F0aW9uLiBUZWNobmljYWxseQ0Kc3BlYWtp
bmcgdGhpcyBjb21wbGlhbmNlIHN0YXRlbWVudCBkb2VzIG5vdCBvdGhlcndpc2UgcmVzdHJpY3QN
CnNlcnZlciBiZWhhdmlvciwgdGhvdWdoIHRoZSBhdXRob3IgbWlnaHQgaGF2ZSBoYWQgc29tZXRo
aW5nIGVsc2UNCmluIG1pbmQuDQoNCkknbSBsZWVyeSBvZiB0aGUgY29tcGxleGl0eSB0aGF0IENC
X0dFVEFUVFIgYWRkcyB0byBORlNEIGFuZA0KdGhlIHByb3RvY29sLiBJbiBhZGRpdGlvbiwgc2Vj
dGlvbiAxMC40IGlzIHJpZGRsZWQgd2l0aCBlcnJvcnMsDQphbGJlaXQgbWlub3Igb25lczsgdGhh
dCBzdWdnZXN0cyB0aGlzIHBhcnQgb2YgdGhlIHByb3RvY29sIGlzDQpub3Qgd2VsbC1yZXZpZXdl
ZC4NCg0KSXQncyBub3QgYXBwYXJlbnQgaG93IG11Y2ggZ2FpbiBpcyBwcm92aWRlZCBieSBDQl9H
RVRBVFRSLg0KSUlSQyBORlNEIGNhbiByZWNhbGwgYSBkZWxlZ2F0aW9uIG9uIHRoZSBzYW1lIG5m
c2QgdGhyZWFkIGFzIGFuDQppbmNvbWluZyByZXF1ZXN0LCBzbyB0aGUgdHVybmFyb3VuZCBmb3Ig
YSByZWNhbGwgZnJvbSBhIGxvY2FsDQpjbGllbnQgaXMgZ29pbmcgdG8gYmUgcXVpY2suDQoNCkl0
IHdvdWxkIGJlIGdvb2QgdG8ga25vdyBob3cgbWFueSBvdGhlciBzZXJ2ZXIgaW1wbGVtZW50YXRp
b25zDQpzdXBwb3J0IENCX0dFVEFUVFIuDQoNCkknbSByYXRoZXIgbGVhbmluZyB0b3dhcmRzIHBv
c3Rwb25pbmcgMy80IGFuZCA0LzQgYW5kIGluc3RlYWQNCnRha2luZyBhIG1vcmUgaW5jcmVtZW50
YWwgYXBwcm9hY2guIExldCdzIGdldCB0aGUgYmFzaWMgV3JpdGUNCmRlbGVnYXRpb24gc3VwcG9y
dCBpbiwgYW5kIHBvc3NpYmx5IGFkZCBhIGNvdW50ZXIgb3IgdHdvIHRvDQpmaW5kIG91dCBob3cg
b2Z0ZW4gYSBHRVRBVFRSIG9uIGEgd3JpdGUtZGVsZWdhdGVkIGZpbGUgcmVzdWx0cw0KaW4gYSBk
ZWxlZ2F0aW9uIHJlY2FsbC4NCg0KV2UgY2FuIHRoZW4gdGFrZSBzb21lIHRpbWUgdG8gZGlzYW1i
aWd1YXRlIHRoZSBzcGVjIGxhbmd1YWdlIGFuZA0KbG9vayBhdCBvdGhlciBpbXBsZW1lbnRhdGlv
bnMgdG8gc2VlIGlmIHRoaXMgZXh0cmEgcHJvdG9jb2wgaXMNCnJlYWxseSBvZiB2YWx1ZS4NCg0K
SSB0aGluayBpdCB3b3VsZCBiZSBnb29kIHRvIHVuZGVyc3RhbmQgd2hldGhlciBXcml0ZSBkZWxl
Z2F0aW9uDQp3aXRob3V0IENCX0dFVEFUVFIgY2FuIHJlc3VsdCBpbiBhIHBlcmZvcm1hbmNlIHJl
Z3Jlc3Npb24gKHNheSwNCmJlY2F1c2UgdGhlIHNlcnZlciBpcyByZWNhbGxpbmcgZGVsZWdhdGlv
bnMgbW9yZSBvZnRlbiBmb3IgYQ0KZ2l2ZW4gd29ya2xvYWQpLg0KDQoNCi0tDQpDaHVjayBMZXZl
cg0KDQoNCg==
