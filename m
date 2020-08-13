Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59166243297
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 05:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMDA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 23:00:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:37854 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgHMDAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597287654; x=1628823654;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bQ8lr1PWyJ40TwS/HigAGqUEV3ZnnzWreh2TWiVNx1o=;
  b=hwAvnfd6MI6OYC8ieehrV98xAyOHDOwf/4ouXvA33XxEBBjcSNokK4e8
   ViMr51JB2SXWgX4hpafLT1dT0l95t72ZW76NYuBRQH+AHfi1YcsKJ7060
   jPQyafpBTC5WOzeeuvaIui/GjDEPGSn2m619smdF+QOBCMuvDL+DchhOH
   KAFDoBmtnBwMQInEdjO7vn3gSlDm24KYmEB94GZImST5j+8ebPgjF+69F
   RdTNPUo4A4f2RuZxgMbleZ18spm0iBtzh3HqdzomcZ1BZ+GU9MwXT7i25
   lKOSSjjzO3CUqKVMdu3YOOviRCaiSXmyliCSiPM4OguGcuPexuTxda5lG
   A==;
IronPort-SDR: fDrpgYvI4RpVCxtxFcAMaRn5TH5NYs7T4+rMAK/OcSqGHh0dIHkIZsHHAf8RaB0ZZV9ZH+9XQm
 NSXUAxYl+8GJ0DYI8w5ABs8cvMAzXILRyM30hjTHg3ogTzJNVzhcOTZ3++tGekwhFzVTWJFWwZ
 ZbxHJ9yZBKoygymn5qOGO02gHAsl/MZrGzUwFu5vbfpjYnGpbWP94gabeq+expE/OmXlI7pBVm
 tqBUSkwsqaqA+7rOv2jUJRHsqY7vk+siRJZo84+MCDpVVgxfbUUr4Npad/tQV8B2VBdGpoNNFR
 6oA=
X-IronPort-AV: E=Sophos;i="5.76,306,1592841600"; 
   d="scan'208";a="144813513"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 11:00:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P66/tdTHDp4X7V830PaJGiQXbkzo2NeqtoYUXMURtNVFa6qH5uk367rMdWfAmgUndn7VQssRWvR3zbgqf5uofoZjNpsvOAauFR59FPNFbHaMaZX2v2Nzfkk6iUyeYYtkLJwnFd3BqytXo6AIqShHDyy/dRIbZhlbtygsUBMh565R95h73m8paWjt+RozErLORhsZAM2dGk8CCo5oVOz509pZbzlQwykuPy9YAQlITAWgDTje0h2Z0TnP4glqESZS0H+lX7Bf/SYXgJ91TQg84yU2xy9z993dneevV3tCHc3Ef8Vq2xOwVO7vp03IIsEEm4UvKyBwuZhCUmT/rhQa/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ8lr1PWyJ40TwS/HigAGqUEV3ZnnzWreh2TWiVNx1o=;
 b=MB32/0VWawWTTawVvvaXrgfo/psnNu57tvv3c5yNz/RvTx0mVwzxlQ8UpbCHCsew/+JDSfRSAF4pBEDTb8iV37Cy1cVIalhBB9VtbWs+VSxD1h2GQSz5iAWzm5GYgRyuab97+op9PAzrS8yTS/yW1i7eHuax+tSOKNdYum3T7ZUgl8sJw0bmcg5ojCxmajjdXrvWGgv3GqWjYQM/BorkKwgDA9ZJiPsTrKmrrtvx+MB86rtWjbIJHwcA+w1BztglxU4ftRoWeRT2uoP/JrSCZzKEJpqwhNCaF1yPAwgms8nfZBpk8R6HE8l0DSM3HX2YZH3bt6MlItvHorZsy6bNDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ8lr1PWyJ40TwS/HigAGqUEV3ZnnzWreh2TWiVNx1o=;
 b=zz8nQSQAwYQDoJoMswHfRTh8KndaSfROdPDHQwl3pxT2CBtFzOCFrfB8mlBsfO4awEhnY+HwEJ7NY6SsbwaRoEchZHLZosshPfRThiP6xiDjb6LVziRP+H7oRXD57wmCM5qu5xfn4BavGdAxNnO7FxVwRnFUEjeMMLszymkINOU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 03:00:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.025; Thu, 13 Aug 2020
 03:00:53 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jacob Wen <jian.w.wen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] block: insert a general SMP memory barrier before
 wake_up_bit()
Thread-Topic: [PATCH] block: insert a general SMP memory barrier before
 wake_up_bit()
Thread-Index: AQHWcRv/yzPrpHN5K0eDRQ61fXSrww==
Date:   Thu, 13 Aug 2020 03:00:53 +0000
Message-ID: <BYAPR04MB496566C1445F60DFD2A05E0C86430@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200813024438.13170-1-jian.w.wen@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30002274-2cef-45ce-f8ae-08d83f351760
x-ms-traffictypediagnostic: BY5PR04MB6849:
x-microsoft-antispam-prvs: <BY5PR04MB684986A7E1F7AFD13E25565486430@BY5PR04MB6849.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8YnCmoCsGwpyuXOTRYI5j54mDR3PVn7i0zgbGWKplOmBKD+qeJOiZJfs03UMGZxYZYdfrDHxCSpeoBr1HL/6RMuBwKLdghzLh31vixcj8iOTpaL7OCLCdZ6NHBFJbTosNT+P4Q8nAYfQTN7KdrbABrV9j4ACq3NS6ItS3claKvVutUdVl2jFpKdKqP0TU4xuUF2GSuFCtiC30XxXsmb8P55LTb/a3nXgs3C38I94U+36o8eN4igoKMjR16MeEl0ddHGEbFWqi2l/WVkgLBPKAWAPSDdybI/036sV6ctGrf8gvVGBxwtRbBQ4PjuT0ffVMOQxEUvhzh9tRpA//MxqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(26005)(5660300002)(558084003)(186003)(66946007)(55016002)(478600001)(53546011)(6506007)(9686003)(110136005)(76116006)(33656002)(316002)(66446008)(2906002)(71200400001)(7696005)(8936002)(66476007)(64756008)(66556008)(86362001)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HtMGKqp78OSupJdwyae3hEMZIfYGKpEh7Xw/IoiFs2jTkWfcvDqRZN6iNS/zjLLTW73vsKsUsyarebul+VaFiG7HLodDEvK3POhMzVxe3C5BFphnZFgFezQSCuTMr1IKBYdqEjif/7z5iYC+cXp+YAmE+7UFEneYFAbnCgAxNZpQsiqBuatvrH5AHhEG7XRWqf464T6KH3VPze3NAwbByRpsnhn9QOxl5zOnvwuKlgNECsJfkBgOkOk/7HTsATfFYnejhXiYdOsOUAzMsCI6QLzAdvX9NMTICm6uzXnWbLZUCpgtDLMqyC4CowX8UEF2DgQf9JcScyu7vXHSKfDoCcDBrmdqS97GsMmf3e2a7WIf0/NAqInFTqgohgNsILWyVLlnydbJzLF8d+xB2WOlif2DZxG5Rxouz9G7K5k5Qv0jetxy5je/wU9gT2QISCIo3+pBQy7HkginAHl3HowzAr5lT6f9w9Lm9SHLkKqPHaCbQOqmTJAGd293GhTxYs9jLItmaxW2oRS6gmPabt4PwmMHy5K4lucwfqBTQvaBjnO4OdD1ICbS1On6N7eInNAmE1zS+M4o/swgLj2sGMEx3ABHvuNi7G+87dicdfbBcWpozgB6yQadjOQ7vzVJ4RdVPP84iyqih/JOS6uUfXCafw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30002274-2cef-45ce-f8ae-08d83f351760
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 03:00:53.0303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixUP7EODDFUILMsZfzeBTEgZvz5uRbqiLBNwOB/OyaSCswUAhNfr8CMnYgMfsvhfy8EAYm2/WdV5vSTmDHOOPyWQ/Nfl8N5Qj2CWNLrPOT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6849
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/20 19:46, Jacob Wen wrote:=0A=
> wake_up_bit() uses waitqueue_active() that needs the explicit smp_mb().=
=0A=
> =0A=
> Signed-off-by: Jacob Wen<jian.w.wen@oracle.com>=0A=
=0A=
As per wake_up_bit() documentation this looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni<chaitanya.kulkarni@wdc.com>=0A=
