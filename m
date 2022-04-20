Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1965082CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 09:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376482AbiDTHyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 03:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376481AbiDTHyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:54:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1925C3C4B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Apr 2022 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650441052; x=1681977052;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=HoCfip4eQMAcPnbGTILodEQG0IZ+XgpX1qmJx5O8EJECOPcYhLhCNwBm
   syrIZt5KcUsje1T4aO3VjdPvV2Bdi9X3c2XMieq0m9K3MDqcPmpTOtv/0
   ryOylQPhYg+dcSSbaslo75JI6iX80ZhsaD6uZFb3h73vBWvqiHVv0vD/d
   eUbXu+yX86GK3cQyRD3R11yom3thtaS3B7akGCNV3UKDtiar7xS7rXbkI
   gBPt4xp0bJKwLjhphGtdlhz9ojKx46HmS4h3nNn1IkWD5iBo+xh6wQXfl
   rfuRRPtFdFr2/WlZFGVwK3vis7pmLL8TPzRMhWmnPtDRB3T8nWun46rVZ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="199237747"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 15:50:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj5F2G4XHi/Rj5a4mryp636cKx2rad8fWtlfh03AdKzBvMog2x/RQ57gzEPc9BMNQHStez5uJbt81FBSeX5p9RajxmGsIs1PEaabiz26hDsp7CkGMK2Eqg7mExh1xFokPePw/EfiEZqWGVxfHyH5PEB7Y72XLFZx2LjsyYFQxVNQ/Pj+/UGHckrbGQhLO4Abl4r5XjU1bNeRMA95Lyo6ckOl+/CLlYox3W+CdbYLdIhQP+jLepmetezHZD6ZDk3Tyv6K4Sg37XrpHHGo3RI3yB8L9xz7Uq0oeVP4VOVZfWp41gdZ5Hk4lcU/2RMkHmDeFkCb13ZdObnWbkvK/P/myA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XuTJefeTpTh1Hka0/TDazrLoAtYTSl2MDFKShWlLviRMCeyR28mlnFPs+zH3lUxUuUFx7h7jzs2Fb2rsnovlxOQfUKkU+U89elVoCBIUEzLMbFeEcXvBqfCBD/iRJNJVOCfp/qWJlkvo2tyjQM3apeHrRYi2pzKQv6TuVZcF9zlMDbG6/lSqZliSdGMGNlDHFIKN+lunMwhFabMBsRZ5mnM2qqCKZyrxWPDHJgLHCeHJ8aatfYQyuSMqBO7+nvFar9NxZ1EevxF1kp+HC5Tkci+2wbwnZ/OSF1h9rlPzLTNnwWUOYfR3bOG9j9nPwbBUUiD4+hbHcgHBZG8g/VllQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Muh5+BPxsrYPHIKdLG9zTZE8/BAiHGEORqM9eNzJ6hF/azoyrpKKrh7XE5/csLMgykNnzHaJFS3nHg/sWby0akXAuT6P3iv+IaCF1HI1GWHYP0zv8wJyOSY4u0aUBpJb5HgMuuTfZyWU6wxzGIlJ3AkPBZLFHif+AIoamjAU4t8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5556.namprd04.prod.outlook.com (2603:10b6:408:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 07:50:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 07:50:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 6/8] zonefs: Add active seq file accounting
Thread-Topic: [PATCH v2 6/8] zonefs: Add active seq file accounting
Thread-Index: AQHYVF9hhFK6d5PiqE2LUrcMGrssBw==
Date:   Wed, 20 Apr 2022 07:50:48 +0000
Message-ID: <PH0PR04MB7416CBEEBBD6C33CB93F95C19BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220420023545.3814998-1-damien.lemoal@opensource.wdc.com>
 <20220420023545.3814998-7-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28696857-5fea-46a6-427c-08da22a27bfb
x-ms-traffictypediagnostic: BN8PR04MB5556:EE_
x-microsoft-antispam-prvs: <BN8PR04MB5556B814BDDAD1F49300AD6A9BF59@BN8PR04MB5556.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7T9vYZK8dIHpjYOjfEsKfDnVKtFa2Px3xw/unQJ4ZHUlT2LAPSoWuC/mfSx/pExJI3r0R2RWejkulQ1JzW8oMvxpwvfK9zNwrsTWud0L4gnys8xyKbOGSf9BjtDTuktQZfLh4cBVVGExBVbNsxvhJYmdVp2aaUJ0/3m5AUMhDL0D7GPdKYhr80lB5W8Eprygj0AKS91hRj6qMzkTRHtHThz1vbD9ffVzGdpTt1jsmizBTvAuS7ffPcAuDX1cyVO1tZKjoCmdUO3B1xicYGIRJX6t0ZXY5jdhl7twMs548mFMP0mK3+LhCI+2VnuthF4DLLoJm6laEmmuCl9Q4RstIgVvBvjF6Q3OBYIvB5g1LzlJ2cI3S3hFnja2aLQGV/13r8Gpy8VEJi0eTafxwt4j6zloMs2EE0hFHa0e/Upf+JmYph+lSkGzldWWLVZ0vFZq/rh0A5XEj+Z17Srb4Xm+rD4szSbz+h6CWzs6JT4Hm/21SCz/D9/psW9l0ZXXotlctbuMNwMA+MHOEi02qlUmzmMbepUdqcPtQw+mXw+FNO0DczUAJEaq4b68HG2ROvTY3aSzGjA/AYBWYwN/YRvOf6wkJoCj/KXJgf/IOW13t1KKyx+8pR+a8rFG3y84aH9oWjoBzwABMiQcqrQikQxmzh/OnpzY0tmlE99MgFIQVE55HvU5KLItGWOzCQFfL1SpT2uZOBvWqhXoB0kzKwJQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(52536014)(5660300002)(38100700002)(508600001)(19618925003)(2906002)(9686003)(7696005)(6506007)(4270600006)(8676002)(66476007)(66446008)(66556008)(110136005)(86362001)(8936002)(76116006)(38070700005)(186003)(316002)(64756008)(66946007)(122000001)(91956017)(558084003)(33656002)(55016003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6f2l2sb1BRWxD1zKUh1DP+B8O45Xe0gRuchuroN3U7RLTUsHCxtKZqaaTqA0?=
 =?us-ascii?Q?tBpbBFdFTOiXPENBYms9qPPrM3OEo5Hd6nM03RlcNim54nj8sf7BF4B9zWOp?=
 =?us-ascii?Q?6UY7xeCFya+DE/Se5vZsdIjP/OCwdcewK98gDleHbkwHfOWJ7e6O0HD8qVue?=
 =?us-ascii?Q?I9Qg+mUkdUHrmYCNUSw2f+VUOH0INvSRFReRcXNjfBrLLqHgEYhdR6Z35kK5?=
 =?us-ascii?Q?xEQgve962RFeC2BM0pcJ/SebuNZCvjEwEJf0LdCWDljUNScT1HogdNWeMCgi?=
 =?us-ascii?Q?Lxr0CgN8cIysyUk7gX5qXuJYPZPC5mCe5Avj0u1QlFimp4k4h1Owfno+eb8h?=
 =?us-ascii?Q?Gm2BdeSqzCeeHY8NUQQtC8o8WjROfw6GAjv1q6xrmigswq1/tYJiU1bwBCd3?=
 =?us-ascii?Q?mjxuuP2dYdfQapUe4Dz+QqfxmxwdNClx0FIipIs0PJm8JcE5QP4Tn49S4gvZ?=
 =?us-ascii?Q?DvT8IydgX+KHkQsd/G0CAWMwuDdkchtZUqPYownorAmAj+oANBLzFLk4afKT?=
 =?us-ascii?Q?lZZ4neXCPli2HGJFSSx2na1wTqaYBacGd/aFn0/y8lJd7eTu91IfAmVObjgI?=
 =?us-ascii?Q?Pvuul/yIGim73fKcM0cAalaJqJGebfib2+TQ7KW+8tB4DG6W45o1j9s7lFNU?=
 =?us-ascii?Q?MDaFhFe7PQ/Lkuyc3BNJ5aCTqoYCOmQ0STbyJVoYYH61hIBlfPo+pf6t7CFj?=
 =?us-ascii?Q?F4k9Zz7Ai7Ma1mEz+e/dp1uJNZUTU1g0NyIzaYItjIci+jXZCFmRKPAYt3C3?=
 =?us-ascii?Q?LzoADHAIo78HYGcQxj+BZmzQv7mwYldVXDY81kQGpH7ZMm5P8nHNMHVJBJle?=
 =?us-ascii?Q?odJD8yRoLUgfnOHTzsbxWQoAENNmlZZGOayoRUxCPq9ced29OHNh4WWKdVy8?=
 =?us-ascii?Q?8nt0r4SIOAaPjsQCew6Gm981ha8wp5O4/7sCPnRLaXx2wwHv+e9iCkmBlEqX?=
 =?us-ascii?Q?mtUEI2VPS2LV13O9FR5Kg3s2Qal/JCQI8nWIRHksPzsZgdKwppTmPf1eR/Om?=
 =?us-ascii?Q?PKvLEBBgBvU3bwiWPePm0yhefClaQ8enHR8I9K8i1rGKwhZ/3cZ4JEMba+Oc?=
 =?us-ascii?Q?+yzYXKAEcMEKfoLu8tqPkiJhulX1lW+r2jPnt1zTt0chb7XiXyV7lmHlmkyf?=
 =?us-ascii?Q?Rob7ttHPZRH9BZQJvxCMtCKr3dDW4AU30GW1sVfuUuzOm8bnQQOpD0gEonXK?=
 =?us-ascii?Q?9fVhj3hTfuTtyWIZ4dw21o9upSLFbIZIJ8HFd+MXppE19Sf9Iew+267pdnjL?=
 =?us-ascii?Q?X/iHI9+jZ3WTml7lEPJS5cX80A2VUUohaG2n5E5EKhHn0zgP5US1AmkP0/TO?=
 =?us-ascii?Q?osZzkrvtZj35y5ZAsX3r/vnLPpS80DMjHCwXwh8qfnxeqt2JC1Xn0mvhQWGy?=
 =?us-ascii?Q?KM0XsT6PptyrJ6RaCPeeUud2R2+B+/mPWj0bhKDlJo74/ygEypqm9n4ytArA?=
 =?us-ascii?Q?PyFNGdS0JC8qBEpDH+pcWUlYShZnIsadDe8/MOqZLOHpK7zCtchp96Aofnlu?=
 =?us-ascii?Q?mag5Lv+EOIGnHxTf9JkudQPIJiMJefkGv76rIvgIZWkv1U6SpFozlvt9WhHy?=
 =?us-ascii?Q?cC5PJXA2zJWzTBHGDmWDSGnCtnrY4wkhY+SP2YomAlsn+OLE46HbPbz0viF5?=
 =?us-ascii?Q?a13s4jQhdun7PtryWOrQ8V22VNDxMdfqwXy4mnHxzd8Q7FXTmsme3LSAjfLx?=
 =?us-ascii?Q?nc6Eed/Im52e3Skr5iD0A03z3v7iJhf8he700nPjO//MOQbH8NNY4i7EoNHb?=
 =?us-ascii?Q?tBnEQCG50XSyD1JWjh9KYjiB/F2NrbA10jc5cmb7FmPL+GcZlecQOYm/ZL1m?=
x-ms-exchange-antispam-messagedata-1: O5nn0a7NxVH++WBmx7eZOcyLjVqsL1YcOlYZmGtUFbg/mB4wW8cITDXo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28696857-5fea-46a6-427c-08da22a27bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 07:50:48.6300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5RfEBFB1YAAbBjE9cTRSYG8JfHU2ZhJXAU7BPlBzaMHBe8lfcXUlSkWiPWXC9a1fnDevk62mSJ52PGmClpE5ok9nWT+00L9WZmTll/jQ97I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5556
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
