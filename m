Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA89F2291DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 09:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgGVHOP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 03:14:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12069 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgGVHOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595402055; x=1626938055;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eDgXJDrRcHBdx/h+ukaTHEZJ1bIcCGUbvV+Qo/Lb7u8=;
  b=goq7SPTtVHeSbOVnRlL+laylnxLxmkk4dDiwJQ20ue23IazJ2QHanXQT
   ZLtEfqq5l2O3uxrCfBFonee43UnUlN0PR3uBfx8XpPkUGSkfdDeztJEiO
   M2Ew1MnJP6z75LMKxammYjTo/GiwOSnZtjvWaiGr8NucYMqp+bhx7LecO
   +ZM+zSEGD1/0w+AODrglYuRcqsETZbjD4rNFXuZcEvSU2gDP6rIyUf+0K
   d7/n0RL4DUzXXG+FyTyL3b1aNy/43uo+O4UINWONDgF4gAr0L74PEzFfg
   OU/CR1lOBFfu6SzddCuEY8gPGlTdT8HmD3BJcnJITVFDYnoNZL4SnlWf/
   Q==;
IronPort-SDR: wHJ0sUf5fKcvjCD5KELUHIpZWn534zNWdK/RdtaRiz1HpW9fNPYLc4k8C4dqSOcfwS/VkCC3rx
 Sk/DCgaT2zjtuKphqdg/47ePdrawLXPmVN2QMtMo7E0n8aRVX39Q9GoXFOciL0NnbEnGthc+oL
 wKE8O+fmKJh/ArDe+3CyV970ETjHHfpr7HhppoSlYWcT+6B4L74A6J91BUPCZjsV+IQa9ZmuOt
 HXgR1QxLxdU3LtzIxWgZq9O38VJ9mu1kIuMuQbPMcgkwutxKcStu83NVlPH/mucXJPrT+HCdyA
 TL8=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="143183356"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 15:13:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHoUfvDb/kH0zR6mxIRvNX8FNQPu9uGYgHKnoRdnMOBY6xGiervqOLb7pqlqs4sOYAm0IAKucRJKiYCKF+AtNJoTEa+LBec/WeO0IHg4etpuih579978R6SPb+WzU19Oo+HpBE6wPz9ObYIpLXyE8ju1V2Wh56IqI3kgqXsvMHc2/P0GfSbfLUaBQhMuAe/LF6iqwGFIh4f3e9NYmNGFqDMOk3hTyzvCzeI6dbRHF9E1qGEbdTJuLzjkURe1Q1WrMSH14rPq5iToCspKc0X6jIhgjgjxVm0pFX+Um4nqw52iiyruKz2BcUR91fjfcFkRPEAMoU0icnG9rliPsaTTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poiwM82pTnOPiJnHxVcFkqqb2XVkaMdwQOlgju+7S0g=;
 b=et0WO/inY40469u+0eXd6/sKGwXMBWQjpBcH1bRYyYdAAjqsnFAvc5J9zAkvv2eFurie54/v3jeg9gglA1T4E2B3bRVRyccL/TNCGHRiJOFqzSHDd6JSHTZdGO1tgKBHOjAeNXVJ+xuxwN0rlMWryGDg/s4+ocByHOeMBEtNPbmTjU5d/Bb1IYXwpsjxNPZAF6L20VIApca8PBc6xi3YT8Kt7PQGaa0KPJy6TAKcKR50VIU6hb83IHuG/Rsighle0oaYAz7h9YmJfGWgQXN5x1ulJbTqXXRD02EEylTR3UEYpEN3z9YlE/k1CVhbtS9jvzEYyAFLmArfT7elvt3+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poiwM82pTnOPiJnHxVcFkqqb2XVkaMdwQOlgju+7S0g=;
 b=fb6snm4DA8NLZm2oGpMp7J/pm7U2fsnXO6PhYWFCFyVRMrh4KmYwDa9mImLx30Ku8pISeP92XEpKj9pvTA/e5uWUSC75GEKjgviQcA7HLvtTafGxQYc/BTaJeuseq+lE0ne5eq4E+N03ryf9wqb6RSyAR98yw+Q4IWKCPCKmNuY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4862.namprd04.prod.outlook.com
 (2603:10b6:805:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Wed, 22 Jul
 2020 07:13:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 07:13:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 06/14] block: lift setting the readahead size into the
 block layer
Thread-Topic: [PATCH 06/14] block: lift setting the readahead size into the
 block layer
Thread-Index: AQHWX/E8oA9T0pQ4oE+KEOpJvS2fxw==
Date:   Wed, 22 Jul 2020 07:13:54 +0000
Message-ID: <SN4PR0401MB3598470B14C754768A2D8F389B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200722062552.212200-1-hch@lst.de>
 <20200722062552.212200-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8ce3f04-9052-4911-3702-08d82e0ecb78
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-microsoft-antispam-prvs: <SN6PR04MB4862C0DAFB1B8540DFF957779B790@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oImQpW7CKR7N7nwIN1ti/wtbBp/l+aSnH3vWZaECMFtX24P/1CMnzbX29If187tW5gzPOp/Abd9iDRIChfVwCh0ocv3+uQnJ/vgQxvyw4DtEr5Ri8DnHfK21NP/3blMOzvye4EnCY1CI86qK3DwYS24zAffmZ/Zb4d5H83UZqKo7CNUzdPXa6cGsXGeH3nYtgrG3mMbbeD+wZDGBx6eHnIwTyKovexz8a+Nw+UHRh/EeeXs8IkfTGH1iBTTfhyleJni37gTbf4HHSYtqRyLlmr8N11xP2cG+oij6V4aHXQpr+fGkjiCcwy7EUvOQj/FX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(4744005)(5660300002)(86362001)(54906003)(110136005)(55016002)(316002)(52536014)(7416002)(8936002)(76116006)(91956017)(66476007)(6506007)(66556008)(8676002)(33656002)(64756008)(66446008)(71200400001)(53546011)(478600001)(26005)(7696005)(66946007)(4326008)(186003)(2906002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AxmEmfIEtMB/QNBNkjYO0i5tOMkxYrACo7fUJCxutjk9dK51+hUTxS9xhs0KRXjsEwHrTutRbj39rO+6WDkKMYq4tuInYXF8qvsqGG5GRkyN0uIbObp7IahQoADuB+q64e1MaWz5hJ0fLB3J2Kk+bOxcR48VpSd/SfoN0XkedZIx+CfIopPeb+EyZZFUC5vQyDARXICGh6pZVelsLXAQAD4D1BDAd7kbhYQhwwBLedQau5lz5wbiFpmdw+J8dKqMu5aJ4GgSSLl5Tshyh/De/0OlpzL50/MDQBrc5fRuIcX6On4KBc7jN47jlT2YTS9NTKD4Y47mm2WvQ6Z+QtXysI5wayIIKhG2Q/XsFZgVyZgX/YTpLLGNAx2YkSVd+oP9dZy3PRjAsShbIS1FHWBvgOjyw7NVnkZU5Ol3uANJ3yXjPI7N3lvifIXJ5o1FJlza03143dIiZEvXJrtLhFL5ao2iK06hxls/+WUNUCudWmkqKo3LNstoM9dsACcPbBeb
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ce3f04-9052-4911-3702-08d82e0ecb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 07:13:54.9928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wocQapUT1WYCqJh62OVuMi6iUe/l+yc5vIOJHS23u+JQnUgO7kjh9b2aj7QsttihnkJ8Otno8w8Ezb9/1OKaCEZwclMpba2Nbu1PcZUT0dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/07/2020 08:27, Christoph Hellwig wrote:=0A=
> +	q->backing_dev_info->ra_pages =3D=0A=
> +		max(queue_io_opt(q) * 2 / PAGE_SIZE, VM_READAHEAD_PAGES);=0A=
=0A=
Dumb question, wouldn't a '>> PAGE_SHIFT' be better instead of a potentiall=
y =0A=
costly division?=0A=
=0A=
Or aren't we caring at all as it's a) not in the fast-path and b) compilers=
 =0A=
can optimize it to a shift?=0A=
