Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64B50867E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351910AbiDTLAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 07:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352438AbiDTLAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:00:42 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31048344E8
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 03:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650452276; x=1681988276;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
  b=OPTiD2/nP/46UoWkLQC7sJxJ48l+vv8xvPisCMcYdU63RZczFbws2PVz
   U665hlLKxlwAyBDeZbrmUPGqhRjhPXUkD3tXOEFuWm9/fjWeEfD3y1dIb
   YiQptRWdKwlNZEBfL0aCerbJtNiwhuNJUmWkloUOd5lDpgys/M2DfnHaq
   d1F8WK//7l0hgjJzEWaOmnMT0PIKr6TVFQUET92MxkoJ9pplZDg0cVrOm
   fT/UUpMdLNw+WNYRTe9daMbG6rTMPZFsvgQX4u87ye96mjG2FwBSXwrm+
   bAfWzpJQGOQnmIuJ8PDzAjJf/d6s9MrZPGtplqYjqSwbS69/V/uPh39eU
   g==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="203223025"
Received: from mail-dm6nam08lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 18:57:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mbe9tTXEZULNbmoKIKX6KxKKYTaN8OPZrBlXPQxFndrlySSX4ZmcwNYV+1nIbDhVb7PdbpkYfONnvTTzkb5Do5POrOO/SjRyir8RqClTRATIvkX6HE9yCdK4jh9OChn9WyuKyknZ88dzbZuCB4VMCkTp8swrEYzEpZ5Lw7a4Y+py8oJ/0Zb/LlkUXEj2cA9Z4N+jLX0RJKOnfUALahx5+HnAHRMyz1YkORilIw5WygdkjCC31otdUOwp5umhSQxz+Z19ocEY9SA/4y2F4Ki2C4U4dKHYFyIUNHUEgKzeejGny8FHX+XlwLb8x4quFlZPS27GHh2kOG7r+RKVfhJp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=X5aB2b0TGWWhfcqGvndoLFZnfpdE+l8mKJTUxBG0WgLWlZ1nyH0hzKsvSkk5RVxLrIqw9jl59CRUVqLNH62GzxI+RIpOlM1xgw4dVfI5ipI++Y8TOOdyAE2rCDET5jBdJrlHlF4ynz33awgiHQJPaSy5kjsfs9NfZ2gJWyLbm+vh5Ir90c4uf0xed/uc13Fxf2B5fACV52dRiRb03b7313CkgJeqUy/uuOE3vq137yASSRtO1EVMHnavj5l51k3hYR2z5bGub8G5+O7z8loQnnW6NLps/cJ6m1vWS1qUyjbl0L87uyMxeGaVlv0EkMFOpDOnDLtlVksjRFvbPHpbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+jzKfnpr9AYhHwNRY0vUU+2gthfxeK7PJTK1GMxpbg=;
 b=ww+ldrGiPabWIxazhAfMH5putuHU0KOUstkxsTkEpKdlaFBG7sBXKqsNcUE/7f6eZPFeqtcd1xcfOmjEdB+OfYDJ30bUCtkyB0LuobsiTpjFUKxivx5CTlfIekgQKNDyhk3sjUhADm2Xerq9xWFeHjrog7joSojfZQ3NTWbXiUQ=
Received: from BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27)
 by CH2PR04MB6694.namprd04.prod.outlook.com (2603:10b6:610:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 10:57:54 +0000
Received: from BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2]) by BYAPR04MB4296.namprd04.prod.outlook.com
 ([fe80::b194:1e37:62d1:74f2%7]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 10:57:54 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 8/8] documentation: zonefs: Document sysfs attributes
Thread-Topic: [PATCH v2 8/8] documentation: zonefs: Document sysfs attributes
Thread-Index: AQHYVGAC1BFgzRNyakCLRR5w4sY/W6z4ojgA
Date:   Wed, 20 Apr 2022 10:57:54 +0000
Message-ID: <20220420105754.GF36533@gsv>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
 <20220420023545.3814998-9-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20220420023545.3814998-9-damien.lemoal@opensource.wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4185502e-9bd7-477c-e9fd-08da22bc9f3d
x-ms-traffictypediagnostic: CH2PR04MB6694:EE_
x-microsoft-antispam-prvs: <CH2PR04MB6694AC7040649FF9B1E6E6CCEBF59@CH2PR04MB6694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHQGZz7MGbAZxz9FL8Jy576aHLt54vdajpRJKYhdCImTjU2ckuKFlYBBILguY7uyLNUJqIzJj9rQYXcV93fOrSE0IgHb+SHmFGQbpXh1qlG+EkL2nqwp1ZbPhcG80LBpRyaVBXK4c8bvLBKl4UPgTtJXf63rnBx9SUX5RQKFe6Y31N37ScXXZ7y7msQcEpS5Bsix6nS5ucGj8C5vWdsMn7ZxmVR7yX9BcdQulOd3RPGS9SCGV88tQNneuksxCWx2NzbBd9+ZHOE17gURFlNfUew6zttF5dAKCnDcPAK6rqF+vTzl4RpooQZPnMvOLPzipXXqWlX1ZOWRb8+IpSds8SlV+9aJlqMDpq7rWiYvMRmTXQIwT8ZRTmXxeHey6t3/7vCxnbLxKNCIUiMNWCwDvIOFDDPDY+revwFh/gAfiJ7wPloEMTlXkrsqKQ5OUvdes9D+Q+p/N0rlVVEfVcQUzmUYRlaB4Mv4oBFv4zYlW+bjSRlCjBkmkMimX9feBEo5Y3V2V8xf1KFpIv24nNwTRU5MTPLwHiF2gKHawJcQIWV1kHEVvRWheziOBRaaPx3G46uK+3zEjciD2uqdlUUBME/K4wr68dI7hZHdacOCJFF78G/kMCtCNUQ/jz+QNz3mgOCjl0H3Q9GetAvr5yY1K05uejHye7PJVpfEMVKGOTPxyP4sMQd2E4LrCTQ3AkL3c+cUspw8neFr7FXPjXZqRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4296.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66446008)(64756008)(86362001)(71200400001)(6486002)(66556008)(91956017)(508600001)(4326008)(33716001)(6862004)(76116006)(122000001)(54906003)(6506007)(38100700002)(9686003)(6512007)(38070700005)(316002)(33656002)(1076003)(26005)(4270600006)(8676002)(66946007)(82960400001)(66476007)(8936002)(2906002)(558084003)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fbIwlYEHai3rulKZTjdIg5dzfIhxlncwWLwGvAalJq1rvedjcMUwnLmIhYig?=
 =?us-ascii?Q?BodV2A12PKNoXW1uduPPYb0jsIOSiVJLlcZUue6m15tPHQM6OwhKK6/J5xjQ?=
 =?us-ascii?Q?owgAb3k6fBFDSSoiS1ekOv8fu/9QMgIjbqTIppwnjuSsFmC9fZzX7PKXiciy?=
 =?us-ascii?Q?MeNgFPNqzbIKxHYI0NyJRZivsKORrvSRjLKI8nujDTiNZP6yB7fGSiBX5VRx?=
 =?us-ascii?Q?49nDGi4ngBJdGVHvTii5umrQK7sF58uFsI9MNjKupKVMas5/AHdyjuSxl87N?=
 =?us-ascii?Q?4cN+dMU+MyaKmAs5WJCmCPRUlhZCtZmZZqDQEcLEsvW7YKFAe19L2B9NC5uC?=
 =?us-ascii?Q?dyJqN3V/NMzlSWYzYtERUoan1vinkl3HTWm8+ABefrV0Jw9S5RiFW98t25lT?=
 =?us-ascii?Q?kASz8MD9+ixeMw8K+8fwfpRYumTCRIB6p4hz0MFSA3i38YxvnFhP3fqOX3O4?=
 =?us-ascii?Q?cXmoA0Sy/ICs29cldfgEnInKT6grFeqNi/QKQcWWGVXmmExfqX+oFq7PJSAa?=
 =?us-ascii?Q?rdAaLEOdc1UZKOS5pRXAitbyO8ntw0ReLziEknqg8hucAiQd/bPf+onwN7ji?=
 =?us-ascii?Q?MeOzDH97ij8qC/2pFfY24sijoGIVMYLBcRfzGhdO/UAk+hy9t9HANmeOCjEJ?=
 =?us-ascii?Q?Xzhhn6Z3K0jt+P9MyJ4IeN36Yrlaqz8447A7vPemZI2lumpQgLDlC07bmxmB?=
 =?us-ascii?Q?60MsaXHvRK15GLmXmP3vU8OKx6LCjxTQV7AE8C8SF/SBSNxz+CzEJnnZc8Sg?=
 =?us-ascii?Q?j3Fxv+ax082Av7PR377/wIMX85wg3focI+YfTgQplpBNPrjmLZUkAwdoGJ+Z?=
 =?us-ascii?Q?+6WHU3Yfi7wcmkE+lbWRB8bkMzmstS/wIBhpWLr6xQ6qF4HJVNv7doGq+tmA?=
 =?us-ascii?Q?yP0VC7p2Y+94AgfRvwkwhGHZCgjr1Bn9brj9pmNpx/5NCBSR4IVyNUeHpuJs?=
 =?us-ascii?Q?CiIdRsv9Vrzv9a54FdFcYj2g3a4MReWEAwg3DqDt7NTP1BbR6+PY4r+FR++z?=
 =?us-ascii?Q?+H8XZYb8bJNXwZ78kqyP56CX4jq71DOmRSkiG/k7rwSGQ5N4Y5sMZoB0xuYH?=
 =?us-ascii?Q?Lvox8VwyyqAtBzbpu867OMGsXLAghacARvg6JP/c4rg5IlbdklJO/Il41apg?=
 =?us-ascii?Q?iPIP2yVx3HmTkFfhz7dwlwCluKgVSsdRtzhiD78edxZNwZ1ad1nVuEGbnXx+?=
 =?us-ascii?Q?H+cL1MclfCAMRz28DrhnLfWffrrwhWQr3pM7+7wd4DT+b4T8TC9H7iZG1tL4?=
 =?us-ascii?Q?2sH8BYxCULz+vJvXCMupkIrDXM4vnr/XaSZqd0j08jn8mi9NXCdlG+k95tDB?=
 =?us-ascii?Q?C2EZ43xpstGzue+sp/Fftz5RsK4vMO1XS4EI41QAgsFysaOOAoX/5E5b7tK9?=
 =?us-ascii?Q?O31RqwJU2HITQPfz+v5FirW4FPa6dRw/ydAUEgF6yG30OWi/uaEHlMLwj2kP?=
 =?us-ascii?Q?xeAl9pE12q64JE7T8NNVJRGO0WwzXF8FziV0E3UOT3BuF7QAPuAr8xWHBwPi?=
 =?us-ascii?Q?zgRhVXjFwtcm5VZwRXYJuJVNNQf9vlBPyXUZkJi8Nay6ZnHQKks/zQwdONHG?=
 =?us-ascii?Q?e+PZ0XxXykElPfo96K50iRpVWwjGlqmHosRu2bqmQKrPWwRPVNf7ofvWPpVB?=
 =?us-ascii?Q?aphd5hWzg/pKfLJg3w5ca0TtNr8bX6acm1zhmmMPBOzC4cu1jVNSbPtVUhsA?=
 =?us-ascii?Q?C1XU8iQX5KH6SRfA4odpHmfB5mfExvXm9dcFtuNfBzalfxYLEMjpTYyXkRI2?=
 =?us-ascii?Q?zpccduAezB5PXV7wKfPFkNrfNMiUKfI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8829500ADBC3144295DDE5521FCB3ADF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4296.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4185502e-9bd7-477c-e9fd-08da22bc9f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 10:57:54.6864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tl1ktkdn+z7wlSbXhb4E6H6PwY9qm4ihZcRgrFSgfW3wLZsjqio8jc84Ir63k3w2oUpX48gciVCY/LFhjANblA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6694
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good to me,
Reviewed-by: Hans Holmberg <hans.holmberg@wdc.com>
