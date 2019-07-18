Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2450D6C3F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 02:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfGRA5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 20:57:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:63643 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfGRA5W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 20:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563411441; x=1594947441;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kxiKYewJW54cIVQdinVMDKjB0Q6BFMBRoxJw15d0cyM=;
  b=YnAo5CubIMUt11POdEFbeErzDyiqk0f+lxtR0HOhkAU3p2LhT5DmjYuB
   luCtA24jv7HPlZuL3zG4ymkK7Cj2/4/akAQWpfrvK/WdEwUYBk1aagr8C
   fMIZJCjR7x9oMiG34LSOPjXQRG4ur8nrMeNaQoPoZTWY4jKUfUOEJWTLw
   snxUTfKgsJJv/WqLn3O5qZfrvJZSK963asALljdotGFcY3DgoY5dc5WOs
   IHhrc5KIsVhvAK+P51SHC6qRw+dR5DSQxj9DbgZaIF4R8YepfjiOfyoMN
   KlFEpO29rdX6MQn6uOBM/1rByK7jOmkvyXKriYRxkMjZiWcLS5TjwllyK
   g==;
IronPort-SDR: BnjeOcDz/IciCdtwaUrUNEr3eoe9evqFeleJJEm2eSgbRSFqyFuAWpQhtK+soVKJhQApilVSaT
 7i6JwkERgS6/GP8mWn0hiblb8c+6nBuVI++zI/7LBd631Qn3CogAYD8AMFkgWn451E4QPl8c1I
 msr9TV08WG5RGPjSk7Bmn5o6IEWXmiqr57roPN9ywUrvNcg6Tg1IvjadVEWahoA2sWuKDEARQ1
 z/RQzYHNHEOmJAc0HUvpGO4XC04nBFxhdmOpXshFrWjsvn6TDb1lxrn4RU34N+NEtIyWOp3VlV
 mf8=
X-IronPort-AV: E=Sophos;i="5.64,276,1559491200"; 
   d="scan'208";a="219774117"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2019 08:57:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuDu+ws02eHMnunfCSr0+/o/+3zYKbcFX3GwkBgZjEyiu9vbRMMORPWXX7HqA03oHhnwObwZhD86BxPIGuD9yydeoUMAbjgnIH2qWKehktjRWC6HkrWcOssaGSUfVUOVjjpmlNHKVO9fDkjWWrazgXIM5JWgjtIV5Xgv9G3D5mIA/eiskdc4IJKOuy6DCmt8fT9dLYGQp04Q4MMFh0ZSKTgxNNZ+xaABekQ7cNsxjWQl6fE84qYvaVDZH5RnNtygN0wqsNM6nlE3XqiMmEGem/qLvI0aYvOis/RkSZVzeziDaPonll8nqrN3udEI4Ugzu5oUOf8uqJ7mPDsWmUmBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxiKYewJW54cIVQdinVMDKjB0Q6BFMBRoxJw15d0cyM=;
 b=OK4eQAFLmu5XhuNNs519U+CK8JseAEF0AmKmaMHvSUGMO1XdLcJiBEavezL4CADDF/ONSVB5eW6onSq1uoOfQ1ZWmhqPqh7kX7hKYqr+PuDl481ug+g+uQpr190RrpDT9SkpQqgiGgURgvPrCtSuJ1gTFmFhXNh4Ux48mj7knpj4QvswwBISLflqGt1NX68wjlsJ2Dyr4jGyDvqP61Wg+c5szdUWI/Zo5/iwqf7C3ehpRXsG2Z/SsOSs76z7c6CwcbsTHA2UPtYLxDrb+B24reI/xQnvonglM4HEjtU9hz54oqfpgN0zLvjiThTtk8wHurUoGhYSmTJ36VKmn+calA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxiKYewJW54cIVQdinVMDKjB0Q6BFMBRoxJw15d0cyM=;
 b=rXUiCO7Anjf9XqLRPlro3gS4k6677f6sY9U8q4PjGFWxArEHqszgvW0vosM37QblAKqTK94Cdw34jc9LFDTr4Ju0RNtppV+xhqm1S3AYgGWaPtokRO0OTS+YAYT/7OKv8NBXseYWrEy9qbHEMStJ6gUOXZH/XG/ytTPvnZDiWv4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4791.namprd04.prod.outlook.com (52.135.240.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 18 Jul 2019 00:57:20 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.012; Thu, 18 Jul 2019
 00:57:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Viacheslav Dubeyko <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Ting Yao <d201577678@hust.edu.cn>
Subject: Re: [PATCH RFC] fs: New zonefs file system
Thread-Topic: [PATCH RFC] fs: New zonefs file system
Thread-Index: AQHVOF31k+9+55ZdEkmKABdH1mzidg==
Date:   Thu, 18 Jul 2019 00:57:19 +0000
Message-ID: <BYAPR04MB5816F5F607F5061AD53499F5E7C80@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
 <1562951415.2741.18.camel@dubeyko.com>
 <BYAPR04MB5816F3DE20A3C82B82192B94E7F20@BYAPR04MB5816.namprd04.prod.outlook.com>
 <1563209654.2741.39.camel@dubeyko.com>
 <BYAPR04MB58168662947D0573419EAD0FE7CF0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <1563295882.2741.49.camel@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 511ed224-3f7a-4da1-d343-08d70b1ae2f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4791;
x-ms-traffictypediagnostic: BYAPR04MB4791:
x-microsoft-antispam-prvs: <BYAPR04MB4791AC91B888B6EDB21FCA5BE7C80@BYAPR04MB4791.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(52314003)(6436002)(256004)(7736002)(14444005)(305945005)(3846002)(6116002)(4326008)(53936002)(9686003)(55016002)(14454004)(8936002)(110136005)(316002)(8676002)(476003)(6246003)(71200400001)(86362001)(66556008)(81166006)(486006)(54906003)(71190400001)(64756008)(66476007)(66446008)(66946007)(186003)(26005)(52536014)(53546011)(76176011)(6506007)(102836004)(81156014)(33656002)(7696005)(99286004)(5660300002)(2501003)(2201001)(229853002)(66066001)(478600001)(68736007)(74316002)(76116006)(91956017)(2906002)(25786009)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4791;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SXm0hWIAJDsjEi/vT3p2QmXhsNEs7GqsYuwwL1XEf0HPHK6lmC2hOAMCuEf8fN6Fi0a/5GataWEt7PUveuE8upxzAmQSP0rjqezvxva3Xfpcsrf74cgqOeIiIfp66AgQGOqdDtlC8ydxKr2KqwGOJSq0YfGlUcigNOtksMw//N/UyyTKogLxOfF5xi7hHVcDUn8sA7nopGD/Ek+IQSiqQxkcMkgXTuekVuNLfu2P3hNsQX1uE8E02hCR9fVvs1Kim1haGKh8iGLX6rVxzbwnVBzbrorbYqMDgYyIckqRxcF+GtOb5kWd7eRpjGI8P7K/bOxyk0AcKG9Erw9kLCkFFVgrNuHsLnIlKjYsJxaSaWVs1worq3cyhejawgTqdxTes6gbloaMS9HM6A8joQd9pQ4NUIBNIdJ4RS+3B6ybtks=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 511ed224-3f7a-4da1-d343-08d70b1ae2f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 00:57:19.8431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4791
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Slava,=0A=
=0A=
On 2019/07/17 1:51, Viacheslav Dubeyko wrote:=0A=
>> As mentioned previously, zonefs goal is to represent zones of a zoned=0A=
>> block=0A=
>> device with files, thus providing a simple abstraction one file =3D=3D=
=0A=
>> one zone and=0A=
>> simplifying application implementation. And this means that the only=0A=
>> sensible=0A=
>> use case for zonefs is applications using large container like files.=0A=
>> LSM-tree=0A=
>> based applications being a very good match in this respect.=0A=
>>=0A=
> =0A=
> =0A=
> I am talking not about file size but about number of files on the=0A=
> volume here. I meant that file system could easily contain about=0A=
> 100,000 files on the volume. So, if every file uses 256 MB zone then=0A=
> 100,000 files need in 24 TB volume.=0A=
=0A=
zonefs provides a different representation of the raw device. It is not=0A=
abstracting it. One file is one zone. So if the use case needs more files, =
then=0A=
another device model must be used (higher capacity or smaller zone size). I=
t is=0A=
as simple as that.=0A=
=0A=
>> What do you mean allocation scheme ? There is none ! one file =3D=3D one=
=0A=
>> zone and=0A=
>> all files are fully provisioned and allocated on mount. zonefs does=0A=
>> not allow=0A=
>> the creation of files and there is no dynamic "block allocation".=0A=
>> Again, please=0A=
>> do not consider zonefs as a normal file system. It is closer to a raw=0A=
>> block=0A=
>> device interface than to a fully featured file system.=0A=
>>=0A=
> =0A=
> OK. It sounds that a file cannot grow beyond the allocated number of=0A=
> contigous zone(s) during the mount operation. Am I correct? But if a=0A=
> file is needed to be resized what can be done in such case? Should it=0A=
> need to re-mount the file system?=0A=
=0A=
In the case of sequential zone files, one file always represents a single z=
one.=0A=
In the case of conventional zones, the default behavior is the same, and=0A=
optionally one file can be a set of contiguous conventional zones. And a re=
mount=0A=
can switch between one conventional zone per file or aggregated conventiona=
l=0A=
zones files. Conventional zone files have a fixed size set to the zone size=
.=0A=
These files cannot be truncated. For sequential zone files, only truncation=
 to 0=0A=
is possible. That is equivalent to doing a zone reset.=0A=
=0A=
A remount will not allow resizing the maximum size of files because that is=
=0A=
determine by the device zone size, which is fixed and cannot be changed.=0A=
=0A=
> By the way, does this approach provides the way to use the device's=0A=
> internal parallelism? What should anybody take into account for=0A=
> exploiting the device's internal parallelism?=0A=
=0A=
zonefs uses the standard BIO interface which does not have any provision fo=
r=0A=
exposing HW specific parallel resources. So no, there is no such feature=0A=
implemented. Zoned block devices are for now SMR HDDs only anyway, and HDDs=
 are=0A=
have no parallelism.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
