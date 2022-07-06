Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6568556901B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiGFQ42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbiGFQzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:55:23 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177612AC58;
        Wed,  6 Jul 2022 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657126490; x=1688662490;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=d79n7HBlG+HJMcdtaDtKiYmQ4dGfdVi0y2NJAqJf8VSeaGmDYwAq2WJv
   nDHUI8i5uK27Crb0Yv43PYR8SbnXu6cd/OQWLuV4QWvLfC6Osn+zMUna1
   KcM+FaYgzYGBZz3y3i3LAS60tsBf/5ZN//XgGl00Xn3+0R573C+Brs6gz
   /awEPt60KjqWqdFSwE1eLTV09gkFjpjXayNYR3RitjDyfAZb55cDIcsnc
   8uIkgDtj1nPeKdoXAjJ5JUV9eBN+O7uCxnodHF1NowqK95v5d+bfL1XHO
   FjbHsp1xoVH9H6i67f4jHhCi5WVOmZfci0o1f1Gmko/YRHLxllQoQxnBQ
   A==;
X-IronPort-AV: E=Sophos;i="5.92,250,1650902400"; 
   d="scan'208";a="317127640"
Received: from mail-dm3nam02lp2046.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.46])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2022 00:54:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvO3m7oQktSUN5MKHZ7IHO4jGFhPv1qwxp7KBAWsIFhYNhVyLwtPUrRmNuJgxjfbojmLMFb3wkkFECXPyxgk97NV0i/Tt1h7/jFG3f7/4VUtzWuDvJRqYA5Tqj31br9I6SXI+0Tn2xHKIe39Swia9VirS7+igDMgd1vya30rVXnB2n8Q3bQwZRCZRUlo/MLrczO6nnDI6zPSF5UOEesReP3ihZxh71jzHDSSWr4KuDzip29NzisE2gsRohA6SdDsXcjx+bsugzi6J9bRxzMisirhTXdmYVgM+pS4GM6Mkf0YBiU4UQzj/+yW4sHGThqpx3IKkxGNLJX6J47fL+S2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BZNoQQGHIAaRjIVn0xOAOvculh+fLR1MXGgjUSSFhzcDtZd/d2EFqxs3N8JmSZu8pWsl4dp5hi0qKpGyayhveCyo3DpsUQu2rdU6vExwgFK1tyZsA1+33p/viz8ggApdMz4L9LGiRUnGEBW9J6owS0XmHCv/oQUduDa3OQDwWQvz0tn5FAWVSTWDUf2eoI+37NKu0sgNKbZdzxxeRuQIp4hio7RX3wpXiFM6WBHle6NwYIUW96c7yK4xP+707Cya0Hb3CzNtoP4Pp0sz2YkpDsIOe3PGmm24cGSPlI5snfNBV/2YXu21CvscN6qkQJV05uZEeP6b26qSRMkrdOPAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hshRRIKRSCzXxbUezZrZ+XRnZdKVMbjhCql/2ImhPYEBhIRxlv4pRU2k5F7eSZqccR2brnap55+JLcC1vO+Q3cJi5xIZYTY+mpVRVfj/YeggG3N89hl3KY9q38RbzZgGIV/9ce+fMBciwPiX0b8GEwGAjnCmFIOX7EZtQkZaryY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4341.namprd04.prod.outlook.com (2603:10b6:a02:ff::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 16:54:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 16:54:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] zonefs: Call page_address() on page acquired with
 GFP_KERNEL flag
Thread-Topic: [PATCH] zonefs: Call page_address() on page acquired with
 GFP_KERNEL flag
Thread-Index: AQHYkVkYV/Xw//IrHkmWmf/L5CxBig==
Date:   Wed, 6 Jul 2022 16:54:46 +0000
Message-ID: <PH0PR04MB7416063C2BF96536450C42C89B809@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220705142202.24603-1-fmdefrancesco@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 712cae2e-f5a2-4910-ae69-08da5f703b5d
x-ms-traffictypediagnostic: BYAPR04MB4341:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4OJgL7MJiilP5TmcwAArxeNRCutJjWDcJQb8LnqWwvMYswXa5GkcL3DXF7ezOu623eukrxEqdTPbFyrjGQJmL6BAkV1CO/jZ0BxzrynLeJbw85dY1JsauAv6JKXYUrTh/HgbtLs1cW7PEjzkRoSdDGAuzjeoMS2AXKs1votRhcuJ8cO+gQGPUnxtaIMEQL3/pQ7V8c0De05uLRS7x6yGMwczgkFLOwAUNp/Dz408vOED63JDe/68OPRl8816IuMtit2TYAPAhCEhXgohQF+qumqiyVGYc4quz3pnchgn610gQSfQgBrGtTjfUcUq/3EAxVH57Vy+pqOFN5XXBMGYFsGI3C7LX6Hiv6mSIxc+iyQd/OIT3YQqgpXyt1A0BD7HDV0J6posSVZ2QIMZIRIV0HN0MNGqZ2sjtE81CsHwVCyv1PrZ6aM9K4d4q0hVcmLrJQCBTpQHME/fB/fGWSrYjJ9Rf/I/ouW3fujiD+PNyiK7gdFPMnUChO8AG4mjqG+Eye1dDHDlPl0MrrAYp5xVFqzNjDkK2RPVkfO/dxFSJNaBgMJz2ZP/VShZPyWa2Kdlp1opEdIeDvhWZoQPJuFayPXJBNWnBEa/4LabvawVgkWzi0x8v+87gxD5xQ2XiQ+c90jk7zpvWZkBNiPpiUHYQM7/ic2HdsrVYJGraSlIryqVAeuj4TktBS51wk9kPFk/2ctfKWqkUEMLOxhWEM9exvAL4eYYj3Ss5c/ZQ8vfBSp6ylw4d7St25Ea69ByVEZdiOqmMw0xlFuODl/863Iu2Eub+FGZwQhtlO8aFqy+r5Cev8b7BIN/fGSZtT9bBKuX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(8936002)(7696005)(33656002)(2906002)(9686003)(5660300002)(558084003)(6506007)(38100700002)(52536014)(66556008)(4270600006)(38070700005)(86362001)(41300700001)(8676002)(55016003)(186003)(110136005)(66446008)(64756008)(66476007)(316002)(76116006)(82960400001)(66946007)(91956017)(122000001)(4326008)(71200400001)(19618925003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ABbN5FMIXeFQKpgvZaWpA7Dd17AvNfMemRilU5uW5ua9r9ea+nfdTJaTfOLp?=
 =?us-ascii?Q?alha8GwcgcOj2xYnIoNVVPtrDgG1XXinOutp09NQuGpoWNmu/E5xF/m0pBPb?=
 =?us-ascii?Q?8oTJL51RAW2ZfxvxtCd2vxj8ypKFi//zz9U3AZH866wSPMB1mrmC/hO8PbYY?=
 =?us-ascii?Q?V0KfHNQSZNees7eFo39i1/Gyd+1S/fE+QNLJFkPUOrLwqObXoaXzfeVhqR/J?=
 =?us-ascii?Q?4XelXoUS4t8AWZMwoSuoLeSF7DoXyOdh1hXSGYn4K1gn8j7h0IgwN8vERMQ/?=
 =?us-ascii?Q?UwG462+v5SUYOKRPUeu+6lIHlFZ+s9WBDwLslJphBAGln1GAnxjbFJ35hRTe?=
 =?us-ascii?Q?jm2jXMX7tSz0tyhQa0ZkGAcmkNpMdJqmRKcLk8xj6hkQ+N9/SOa9McaBjZQ2?=
 =?us-ascii?Q?FUoUPgyYPuS47jUvF0eLfOsVzAjXjwt3vC6LuxNjaho+Ru+7vd4/o4ahegbr?=
 =?us-ascii?Q?zpeC4JKxzy4vPoumOxuXpRjD4wN9++kKQCohxWVxFvuQUHlqitdOfJzhMPSA?=
 =?us-ascii?Q?A5Pina6o3vyid3m6YKSVdkFigMipNx2uIMlizevh7azsXLhetJ+ME20BkTsY?=
 =?us-ascii?Q?ikPxjXi6PNZ8eZR7CDJowYSwncW+bwZ+HcoWB9DPw1haCfgctmVM8qR+z2GS?=
 =?us-ascii?Q?SJeydjVo4pSC1w608gG/M9/gg4/BoqzsBYzxbowqivL3Lr8c35i6qUTsURZg?=
 =?us-ascii?Q?SOZbcZuIyNLdFIdpie7y1z6+uHHTak41cMpdQWksdVNCZWe0BVjjSwxiIvrQ?=
 =?us-ascii?Q?3jANrC3wm2VEwY/Lp9zkyRncPMEm6IWxduub4MckuNRFkXNFmBJLO3aJO559?=
 =?us-ascii?Q?9WoiuOa2Cot6fjVXCLF6jAaO0n84IlDQRKPlwrCjMUbjv+D72uH4SwEcr1Mx?=
 =?us-ascii?Q?I0B1TYpoB7Yj4fAvIJEEn7fUb4sZ1+UNlDwupOMiqmP/jb/YpJAe1aZeS73Z?=
 =?us-ascii?Q?glahOmy3HDOwzA3moUQUGLrE+bGx98Qx4evqKi/6i2xOB26ezr/JPdgIrOIc?=
 =?us-ascii?Q?ARmCuyUjmna4Ko9aSwgkG4Pd1bAEdTMAIYRRLR42C24Q8mKIPjOwgoWmmvYU?=
 =?us-ascii?Q?MvEod+DFnws3aEpTWO9Nj+GW+7TSsUDeTfYzeOXnCSdBmtSzPyqycN+56Eax?=
 =?us-ascii?Q?YP6qFdWC4qJRavRiawIIG/ZbBY1cpDJs32oswHrrNXBocKJvC410/GxZckf9?=
 =?us-ascii?Q?8XJQ+fMww/kou/6WovSYpSEBmh1lxhx5TPWwTQtzLOH8y975c8Mroi3+531/?=
 =?us-ascii?Q?Ynom0yuogBELZeXD+cIWuWdLc/FExnDL5Eie2YCE/XaBjgW7o04hLtMnl3A1?=
 =?us-ascii?Q?fiRwY6GK8oFekTGcqMHucIVfT/YDDpqss3j8AvUU9HYYyKWNH1+h61ax5CTK?=
 =?us-ascii?Q?0MHmZqQwUt4omjLDpZMWZxVL/OpcbLMm3SV/9F5rR98bAR9SpL1yY74DQ8bJ?=
 =?us-ascii?Q?tWgLXvVmuuBmeYE5s7J+fHDNs99+QXnmanlRhNPvrb0NQU2UxQy4epJU4MaZ?=
 =?us-ascii?Q?lGE6Zl8LZhbqLrGKFFaJDWOGPxYPx59qHNWvArsUibkpMWcDVCXjEekoTLNZ?=
 =?us-ascii?Q?/Tq9ozX1oCX5MQ8A6GP8dJvX35pAceXO/SwQUHU1L79mtAyJsbAG5ogRl1fZ?=
 =?us-ascii?Q?EDi1rQviyWNwF72x5imz5lBWD/dzmtrnwclA0VBSUbEqgRujHEsqeIZVPuCf?=
 =?us-ascii?Q?Pol/xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712cae2e-f5a2-4910-ae69-08da5f703b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 16:54:46.3005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U/qA9XeXQxO1eL3G0GVjuxArNLSVDu1F8BIh4lUBrS2ZvmmynKqhVqkT4O2khwXUl+8H73BKbrcw4eqtoZayoDcZ62si2yv00T3zKTbngac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4341
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
