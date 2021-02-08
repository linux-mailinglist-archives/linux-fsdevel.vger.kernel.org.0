Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD6312A41
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 06:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBHFtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 00:49:14 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15833 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhBHFtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 00:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612763348; x=1644299348;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oXBae0vstMjzkeuEtHHAAdG4N4H2JGkRzMUpKge/s7k=;
  b=ewKmmo7FJARXvYZmcAB4WeIsg8MEhvnjdLNbgzvqucENKCHLx6X58lJD
   1oDi6A7WSo3iBszvDxBbn1U7CorvCXcQn0xC9FAhAeicUl1+eSkIehZNo
   C04KG3ASeH+H2NjrKBynHjq1zfM1KvMZS6+RIIfj4l2h4cX/Ofvbk8SC6
   KCQhhcB2vxUWVApHjhrUozKWnLcPWjQHAx83pdrqFQTfIdH2Ty0m1Mb6j
   OEd3y0YpmJU45DSHeE3ADCdwueNRiIv0Ph9IAWIsykMNsa2VXj3GAUxOV
   YUd90yWrefNgB3Ri9QHIC+sAPlGqwzU1fQEseZW0apT3/LpMDmOE3TY3O
   w==;
IronPort-SDR: +rn3PFkH2IYS7Vz0NXSzQjRhBVarioQLoL1bJOqSu/+QgEFkhaUsu7w1ciG++ZLUTs0T+YRSXy
 cf4VEDidt4Q8YT0Yk8ln4M6adYQwuynIIcip3M7ESGLyFbZvBgfapmjqAUqXPJ3v7fm5SFV6xG
 HfIAVWP349rvqg0zTlU5CLzv76p8sgFgUN3Xq2YnOj34T1OWys57KrmqDqMsicmwk/QFOwBKcv
 2oX4zbm6WiygXDxRTwBJLjNtfuzZfrglobIb+gYJEoI6jAzV7BVEG5LCCrmWmbT6nSlqj6ojw2
 yhE=
X-IronPort-AV: E=Sophos;i="5.81,161,1610380800"; 
   d="scan'208";a="163881457"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 13:47:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUwqGXtPn3q7bFE+TwDTRRfaJuMx6GRRYg22rMQyBtF15b/3p0smO9OS0wOhgNm9iHZ7ZTUGCxGWR++yuXmB0yb59xJwo1SovZTo8XIokoMsA/l9WeUvhoZOkxaSonozXFX277Nk5/OZp4YASwYCY+BstcKceF+HvZHdu7Nblf2hQcJke1/RWIJ9K3+h9TnKLNIrU+/WwHAzrK7SKdUyMWhTYHNClzh6HGxRpgQjZ+37Hvlsf7BDCm5jWz7L3+djCR5iQtzsWTz1NXAOflrSctUEVIuFHcpeahD1KTIDKQ7En2L2gnKLiS0LAw0aDl4/CbCwvAmIt6jhUpaLsy/h3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtNuviKDlGCBw02KUMnybL/jyzkM0iDd7bZioBGALbg=;
 b=Q0P6cW6cN0uOznXtS3sk2VhiSfqFCXj2GWCGwvR/YnqIo9JSWRuyAJEZXN8zi0HixpWW/I43wIN6+GcryhQ5mZWAQGKOOcZgKBWy//xvuAh3ta+xuqlEhAFEWM+Y0kS+9b6zQPujzylFcQZySAnpSV/ide4DHIsA/ukoyRt7+uLkuo3f/dS9ebf+GqRPpHst/3j77ELTNww/Rwce5Y8p8OVCbfCuGZi6BbF23i6C122TIs/Oz17u3Hi+b74/Vy33PUZxxwzZYDbNNmIXj1F4DuKA/K2U4kShGVnc8yjyu7sXvFewt1AvJpuOL4oHNy/uWi8sUkGJ52PWPEIFXCLn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtNuviKDlGCBw02KUMnybL/jyzkM0iDd7bZioBGALbg=;
 b=bWmysoD6YBr5ICbj1ghhJUTzozhpkmHzwUj1LeKvN78t4zdM3BRgy0ZAj1PMSNMEwMvGWkp16ksYJ+hG0Rl++ZJX1Fd3fJHxPgtNGEgExujKzCaYMxD9AyEi9bOATNUlKIc6SN2+y/2/DxNezLQoP/0VfMsylB+NVM6MQ4JN1PM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4037.namprd04.prod.outlook.com (2603:10b6:a02:aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 05:47:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Mon, 8 Feb 2021
 05:47:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 2/8] brd: use memcpy_from_page() in copy_from_brd()
Thread-Topic: [RFC PATCH 2/8] brd: use memcpy_from_page() in copy_from_brd()
Thread-Index: AQHW/YQdaWh4mZ0wR0W6cCAvTz8pXQ==
Date:   Mon, 8 Feb 2021 05:47:57 +0000
Message-ID: <BYAPR04MB496564B786E293FDA21D06E6868F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
 <20210207190425.38107-3-chaitanya.kulkarni@wdc.com>
 <20210208043545.GF5033@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7969b1f-8e7b-4408-fba3-08d8cbf51630
x-ms-traffictypediagnostic: BYAPR04MB4037:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4037BCD7783C45CB4C8D2264868F9@BYAPR04MB4037.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfOcA+TDG2WePg6M888ahjydLivUec96260k9TARtHUpNxIl7B9g9AMTWVtOdTuWNaJTKSxmF6wgaxtLR4REmW6Vmsj5LWyhCXHOZ6XyU4gP4yXwx9owQeWxXB+YrLR2LRpanG+3tWu8WwED+L2Ny1CPDhcSabqoWEcrxIaNas3gkhlgaIWBtjnxz2cE/xJvw1rtw4XsxurympxK46+xDvSR582JEjocEloZs1Zhm7ghM9j9zTveSA6lOaRP+LEUD3sXnfw8lf+PuGDMEMrLoim9PZ9UYB++sJCFrWCycY4mo8eIwyNihItbo3K76gH1sEjb7qg6o+H6uu18F6AnrDN5i2eT78V+Bbdg9b15ByUPaol6GB40wYG9RHU8azavYeT64199xTYlN5tqgtHryjri17SqdvKQwv0Ov/UgyKEFA88hemd9XgZL1HaOLcI3RPwgQ3v3LVA4/XkAltHASrS+SjSBfGKdXW4I8uLih1c2hT2M0UmnNF9wgpQ82M6+2O3jAiLP+Zapz/DyLL+IDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(4744005)(26005)(7696005)(316002)(2906002)(54906003)(52536014)(186003)(5660300002)(478600001)(8936002)(9686003)(4326008)(6506007)(55016002)(71200400001)(33656002)(76116006)(66946007)(7416002)(86362001)(8676002)(6916009)(66476007)(66446008)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?va5iNVGRUEzS+7bgHTSmJ9C8giun24uG5OBji5pxNVckKSxUZia9yvk8osKw?=
 =?us-ascii?Q?gcOdf7XMm7Lx5NDsQGchcLAHCXajXo2BzkWdXX4jbXZtsLkfpQdZ/WbtUQFV?=
 =?us-ascii?Q?NhLSYTYWtJEeq02IL9ZcTTrBW9bIKcuo3BuVCDFLzQjVML1IwvV2feIZN81X?=
 =?us-ascii?Q?jwrjNURMg898aELMwB5JMsovYTpX+xamGkBtgSLRPsqNI7jDvMWv0glA68Tt?=
 =?us-ascii?Q?ACaWOviauYfu4kKTfYH9YeI3H+3mGVJIjB0Ol+Oop6xdQhxZkHY8W/LUya2m?=
 =?us-ascii?Q?U8a6wpd500xf7XvoXffwYJwv35L7QEs42noPPPE+LsUuNHXhTHXUTt80L+dw?=
 =?us-ascii?Q?n/CfgxEXeQEUXE0MciQsrOY8p0+uauCuvgFFBHcT+wDbj9V8ZLJAzILk8Ma5?=
 =?us-ascii?Q?7l6dfs1hhvtRqmoLpJ1nY8GWG2/t9LSkzmLm59TowXSMQUwvcKp0OSdaqUQR?=
 =?us-ascii?Q?KTEznww7bAOEhEE1oL0egiSnwhBjNHPX3t1myMJX4uZSU/OG6QLAqRblTceA?=
 =?us-ascii?Q?0DfWeCr2xjrSNZuAorKDdj3e62cSLRIZxPH7OG01ecbQq/iZsvoRNjra6O5B?=
 =?us-ascii?Q?XW4fa8KWTPopy/p8TfN8rXQ1iHqJLLEaMoLj6GYXGt28LZ8SolXnW+59fajs?=
 =?us-ascii?Q?R2advRXnr3UGhnuMC2bjPsYwG7BgOUEE+P5lfZvDOL2oNa86qiy4zqxLqTNW?=
 =?us-ascii?Q?XqhiZEZjaBU7V1zC/3IjrjgxBNClG0UQJeiOrRAEWCnpDcdkIvwKh2684/Pe?=
 =?us-ascii?Q?ymMaagHOBVrCligGJ9KB0CWACBwnKnY6gXXaMxOcq7Z+4mnjt/1cJk/EaBpr?=
 =?us-ascii?Q?l8fHptdyilAVrrzsE6bLNjQRCcMCELErvjLDDMUm6ngDP4o/bZWpB5MCvHbp?=
 =?us-ascii?Q?pjV16FjE1C2R/1jDW00CbxG+jzNGyIo+0BZeqHsbIfEAM35i37RadNKpWONs?=
 =?us-ascii?Q?aP/paA/GOlgJyWCGA1GysTKVRnBVbmb8xJXFaay+vHaHSKFsoj1aS9IcVMIV?=
 =?us-ascii?Q?KR++RyBPEodvAWAIkhVSX5oz4QEBtfA5V+blQ/OPXIXvo4tI7TxAnKlAy/kN?=
 =?us-ascii?Q?r4kzMj0P7PoTjMIaF114p2YNy/lpXxH1pviE1HYrTPVnsm8DYDW2QEZF8UoL?=
 =?us-ascii?Q?F2WBrFRfgEoPT3/vBK5zrDO4dj+7pJrobkGvOFygFr1IqonVtidshTFA5nT+?=
 =?us-ascii?Q?xSLVPGzivZ3FGedSWONslvf4w23nNo8nWhO02CIHl9ELM5yiG/Jlej1gbm8Q?=
 =?us-ascii?Q?l9dQj1bPizbyjMqQpgHeWKUkHqjTflQ6Q8J8WgNqtZwr+d57NOLoG2tzrddB?=
 =?us-ascii?Q?TJthCk7joCjzzUP1GusfSofE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7969b1f-8e7b-4408-fba3-08d8cbf51630
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 05:47:57.1990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmpeH6fvjjf52yO9ZOor8qgsiJDp4liBIqTYKb0ZdBPhgKYfRvH8Ue7F7iHG+C+e4EFOHSMhasWqFDwKIy04pYNobC8JvC3IgjKoQukpQ4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4037
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> @@ -236,11 +235,9 @@ static void copy_from_brd(void *dst, struct brd_dev=
ice *brd,=0A=
>>  		sector +=3D copy >> SECTOR_SHIFT;=0A=
>>  		copy =3D n - copy;=0A=
>>  		page =3D brd_lookup_page(brd, sector);=0A=
>> -		if (page) {=0A=
>> -			src =3D kmap_atomic(page);=0A=
>> -			memcpy(dst, src, copy);=0A=
>> -			kunmap_atomic(src);=0A=
>> -		} else=0A=
>> +		if (page)=0A=
>> +			memcpy_from_page(dst, page, offset, copy);=0A=
> Why 'offset'?=0A=
Will fix it in the V1.=0A=
> Ira=0A=
>=0A=
>> +		else=0A=
>>  			memset(dst, 0, copy);=0A=
>>  	}=0A=
>>  }=0A=
>> -- =0A=
>> 2.22.1=0A=
>>=0A=
=0A=
