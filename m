Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E9B37EF97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 01:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhELXOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 19:14:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39413 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347056AbhELWp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 18:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620859476; x=1652395476;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sm55gQ1ZKj/1OkHdUl6756eVGD3mjx/fJWQqAkN2ZuM=;
  b=nAdvMN2Eo24Bgr4V+nyEmbIfZq9BmsdI8mc3oxO1D8CwKN02Wz/f40u6
   h9a01BNN/UooPw9wQCU/Dk79OAk/scqDzQqG6tnkatO2v7Q72kDTREi9V
   pP+47SXiBWMC8Xf8MkCw78z+qaWFis++sCIhKL7WdN56ypxaGQ3maUlBn
   w4r3qA5ls8umg3m6thGDIHCEPObVFkyLFpZ1COeDSnkWmlE+2T2WFLuyj
   qeeVcxL0CC1GyL39FbaeK9YyaB/lBdn/UCGnNzVKjxOTCAvUngeX0X2hD
   NWcrEpAxCkn0H4yuCRGNIj2wjEcAeZMToS0QisdTHLv+60hMQE1/VvUK/
   g==;
IronPort-SDR: R82HyLsaYiHRR1tgztZKze0Ws48JryAynEVQ7APycEU6ca4NuLxGzgDssM1ohy9dWMVdmfYldZ
 yODyQcjy/nVlfMRqVOJy/DzkfcLtbfC98B5uK7H0xDXEoRwZZsChe+lwdsABzt8slyloTVhs3W
 rt6Tn5EkDDjjKAFkwGyLrxMFmLyZOX/LbLfnrxlqXTvppc0cjOWuJTv7KX3OtPDX+NWaezLCLm
 HjFRFT4oS1SR/67aV1fIixyPOCdbm3BRZe7l7I3MYKJ2PT+JgsWF4g0g8T5BeIbUSMyFu+HVDx
 ZVk=
X-IronPort-AV: E=Sophos;i="5.82,295,1613404800"; 
   d="scan'208";a="271946121"
Received: from mail-mw2nam08lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2021 06:44:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiHq0L+D/fSdrhvK611q28l5kuO/zLSid4F99xRI/1PIgx24rjdZQe9wkPU+Iww27FpJ2EmkKJJwKzu0G3aX5HFPZwM+qinbz334Hi5rdM9fFXFCNlAGd6ZH47zUagdYrzQS8H+tD7stKHLLX7AyidCcUwyEhzE/1PX3loAZLuQmreH0vyLyBuhN2XeHoq7U0gwmLURS+00YoU4pkE0FXmTYoIbaKxtLGr83YnuI+vc1U08L9MeKyoP2LwiV7YPmIu4h2sc7lpiLZ6BEawteqetw2zJllKPqSrOEcG/BULbGAOzWUxr5/oX4dSt3HyejW+29fa8m06arClkuTOslMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm55gQ1ZKj/1OkHdUl6756eVGD3mjx/fJWQqAkN2ZuM=;
 b=SS+dabDq+ktsNMVWzecDe9Nh3PyBwAdy5x5PsONoYSfY/NpjCm0hMYwaJTsOHr2f7iW/i0vhU9HMcP1NFuPozB/HyRZn8MVz7NTupbOZkJWWt5mtXWhBm3qsbgOmBFF9XyVx8JQfcc0uqw19Wt3ikdJHmHRkXRorrfhMApqFT/HNhC9DeJzvjWKqDKn8sdZU+uIJ9JR0E+YIC1YDqvU05LSaKBZBt31/+KmpXofxVLkaAaPKN9Km7xK/FNxUTt+uDHs9pod3zbPSdCb2kVyyTBSGYfu7JIx3n+TZfnI1z7X8M/IWoE58swFihk35YDSPN+TtXsh+LOrlCbR3ECKyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sm55gQ1ZKj/1OkHdUl6756eVGD3mjx/fJWQqAkN2ZuM=;
 b=K6fvHUqgK9ww9svVtp+khcnNMdJC6uM4bOJ7wSJHNZ/EWCYghg2PAFSx2hLoPfdV1uMY0a0RY+t7H6tG2ACKbg5LWdklqMJ31Nhop9M3lLrsuV0bnkpvagxzGFqXYR/0ob6sB+qCC0HW+4bZVumQ8BVCg2k9IdssrLjECXp4iTQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7501.namprd04.prod.outlook.com (2603:10b6:a03:321::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 22:43:55 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 22:43:55 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 09/15] block: rename REQ_HIPRI to REQ_POLLED
Thread-Topic: [PATCH 09/15] block: rename REQ_HIPRI to REQ_POLLED
Thread-Index: AQHXRzEQ3m2XW1OwPU6DBWj3g/Dd8A==
Date:   Wed, 12 May 2021 22:43:55 +0000
Message-ID: <BYAPR04MB49650209856D5139C507BF5086529@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f373d99b-0f1f-41f1-0df3-08d915976c8d
x-ms-traffictypediagnostic: SJ0PR04MB7501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB75013745B8B33C8B09DBF9E386529@SJ0PR04MB7501.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7xm9rMEwbtT6P+53CA62V5tIvMyH1F821vu5dbbhZVJ7uG5EQTbJ0XK2spG0XYH3SHikfaR9Y9ya/VfrAqsuuaVEaJaC+xnr5mWInPBucX7WuhrGe+r0nnwpaVjIkxG+nFT0F9PFtODprvAph0RUk3zkLYAfOM5ap2+u+3vG2nCxvdJs2yaSOBtBRsyRSPPEHKbRmvV79fGYMYBvWbv/V6WXV2zr3MkJ4Z4M6l479ONkrlub0eaJp/x2moRGYE/7tHi6XQmpQE0lgIE6zEMDGpCwR+mh0GmT1yltshMW6VHv5eF+atuMOaJrClGpsPzsR5p2FYBbxOX6yAOEyu6/HUg6OeJnS6vE7/rJYNhybXiq2/ZqSu+RnBH0dTmi8ffdDB6wH48qqZMc3kIcn7PjdjvcnRWJHotR/mstVoDTG++J5W0kTNv4mXs04PINCbrk27xOSW+A6Lvtn+1GXI23V0iFZACHVLz+CF3SAcvKpAXiC6a8IDTFzf/FmFyJU0DcGyO5pPh70HNA/z61kuO1o2psc7Trj3AZnxecvlqnvYfanoGmNPVTasnd2JhqOpv+vgkF1fSjMJKh73Dp7dQE5DtmrXp6Ik57u1vQbvlP/Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(38100700002)(76116006)(4326008)(122000001)(2906002)(66446008)(9686003)(33656002)(71200400001)(66946007)(64756008)(26005)(8676002)(186003)(6506007)(5660300002)(53546011)(86362001)(7696005)(478600001)(54906003)(558084003)(66556008)(7416002)(52536014)(8936002)(66476007)(110136005)(55016002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GN7OhpOj0ew1UMrXMUQfpjj1TqpegnGlfJR9fUv5gH4MyhIwH2Ogw2ffX7k4?=
 =?us-ascii?Q?XGPlxP+IMNy/XBoOV0clhYwxbW4BCepICYDAxSAPfUxf2iDwp6XCV+9C/9rg?=
 =?us-ascii?Q?g41ep/5Yosu72MBnlVPGlnCA605gVlL2Pn2GCxm8MZ8pBrw1d0WD7mmU/OHo?=
 =?us-ascii?Q?gyWPt/3rQm99GsrbMGaqieDsSQWjiXTG5wU0BA29tD0cjN10ai5v81eSQ/fH?=
 =?us-ascii?Q?MUWGDuiI3eAdnz8g0wgDZm4h6X9fGeOcOEuKiWR1CNabEc4w8Wa81ryWAoco?=
 =?us-ascii?Q?0Jx4QwBFM+GPN3LB6pjsGfyMKN6593NVOs8W3QENs9yBJpuyVNP7vstmvUrD?=
 =?us-ascii?Q?4jTeBpIRywZdDJFPO0JGhGhL9cakHlnCjrAH+B1anNhT0ghga8Z4jUvKFqBr?=
 =?us-ascii?Q?Ot49CI63RDbGGpoDlll2Rdl69hSb7EKA+/TMPHmAoB0p2mxVNsfuyYfeDtmc?=
 =?us-ascii?Q?vIpz8cHK6c1QWnsa8u2T59vQWuW/5owVeZTcUoUSTPvV2pdt6Mn3My2XVMzA?=
 =?us-ascii?Q?H+gz9TPYlDYaVBzE53OBF+0HnpUVtItgDJ9Izti2Ja3/Fv68Hov/npg/ZkbR?=
 =?us-ascii?Q?A29tq/+F1ECJi1pW7MLuRhIruu8gfCfezLgE+PHrGOk+mkKVlrdOXwqg7IRH?=
 =?us-ascii?Q?mYNMn/jQn9vqqB7f8rR5KllpMk3QVdVfcSHLpUzrStiLzY9F1cwlO2qHy+Rw?=
 =?us-ascii?Q?7qsluMXr0/Mlyw+zDhnPjtZbzsZHeVJa6XLFo2a8pnfmXZJaEUTaRomuOk91?=
 =?us-ascii?Q?qLiImzhJtxGWfh5NX6PIuTYng0EJ09Wj+ZAw1jPWklhnMz6Z9G0uiwzvRBiH?=
 =?us-ascii?Q?QlyV9URA4M5vyo/K9FKXapo11Qeh2XQCweO33B7Bdm+9wm1hRoiveld7StbI?=
 =?us-ascii?Q?XoqHOqoh375FGwQ6kEAJVzt1+YGxJgpHsj6mAxCHN9/xJzVFKL2874CBqAEd?=
 =?us-ascii?Q?tDdGur+PdJT+m6fN1Nhz7QEmxPCpnbvteVoPw980vTg9bILocA4xxDy32id7?=
 =?us-ascii?Q?h90hPIVe+tA5WZMF+tDi6zCmOhs99h848dJpZGzoX793PZ8PhTXAPRiUrOx1?=
 =?us-ascii?Q?LZ4VaBCrQSGUWZVOj+1LFeuxpXRQ+oAkIB2eYlBk5495b9cCOQGNMOmxrage?=
 =?us-ascii?Q?ASGMJbSRsfr2CCZSXjmyOFL83xj/E/z233xNS3ZsTofrScKCPoCzBknqDO+y?=
 =?us-ascii?Q?M9rfOj+V6Xu9ZzjemC+0MG9YfniA2w1mNF7LoIdp40Oue8/s6tR4lqXFT7eu?=
 =?us-ascii?Q?jTCOOt3Gkl9RZmGDcY6Ravo+u8YRJj6hLYxbh+7QLNWfegG+wSOSZHCrKPtJ?=
 =?us-ascii?Q?86itx26YvVlJf77/0NoKc3RI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f373d99b-0f1f-41f1-0df3-08d915976c8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 22:43:55.4054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNa1t4piic+H6JJtKVQBLs/yHO/E8S5W9vNavYYYphDGX252quOqRX4nsJTWnrlyREswN/XC/a1+rlcOhpdFZ7paXWuL0VTOYeeX5NVrvNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7501
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/12/21 06:16, Christoph Hellwig wrote:=0A=
> Unlike the RWF_HIPRI userspace ABI which is intentionally kept vague,=0A=
> the bio flag is specific to the polling implementation, so rename and=0A=
> document it properly.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
