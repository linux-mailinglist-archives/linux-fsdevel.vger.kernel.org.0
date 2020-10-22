Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5136A295CB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 12:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896538AbgJVK2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 06:28:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51766 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896513AbgJVK2d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603362511; x=1634898511;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QkrHkb+ZbTbbJfCe6evYJwdjZdRdUtyJCPimiXucy4s=;
  b=mruh280DVwEz/FwkT25JXl3u7AfKlX082LSwfz84DWGc3lohdDIL4iUx
   RqfRhMLGy4Tl77Y/NGtXYnEpmJeaTL/RWoyTadEXMC9ShBktwQsjTrtg0
   9nZ5N6Cf+L055e03R91/HIerG2hFwivZS1dL7fO9S4bMxKMv9Y/g7M6W6
   zbvhYaj8KgPFF+Hmy+ZXcVukv+9gE7hzsgnzg4AvQGwQi34Hy/W1oeNq4
   hE02kSnzRFLLQ8TQ8DTZqVp/+Qf54WKXNEFALZZJ6rDBrHmVSWErkDb27
   qDEOgk+uG8Fes6i3T7mrvCGiyP4VuFg+yA9MvR00gv7Mibp6aFlk2C9vw
   g==;
IronPort-SDR: 5JcddNF2Q9BeAQen4t5D9rX4M2ez0QdkJT7s/+0QkBE7iaulT+PMN8N6bZMkumDUjTXpz+QDvq
 OVyyZrzHXCcPEJrHOxISlHr3VSEaNOLqG0EXcY77Ne+/e9KVnbCtDMgja8QbCJkqfS7NZAEIQK
 e38Kfw9CwuZptV9Vn9P3/yZQSHBScwMY8APdguhIUYoRx8NbqGsD4swDuWTXn90UsHTAd1A0yE
 fSIijixdjZRNmgpxv1hEXfdfVhZApD8P69Cd/02upsJr4D2o5NjQM748610Ee3KpzLgtiP+v9b
 uN0=
X-IronPort-AV: E=Sophos;i="5.77,404,1596470400"; 
   d="scan'208";a="150531216"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2020 18:28:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRRUcGBiQVR5g16mg4NIs3UN5eehRV/ZDyQJzZpH8cQ3OX3PzdPvoD25DlSN2c/aM4aCWNZrTiOWtnxciIRAh/Qk9ow/T3tqNsU3dkhpuE4k7LWbvgLUjDzQBICzsFrO0sPeNsnKCXEGNEl8Sn3hyAbKsYF6r5RLSp5WuyWLYWamK0eIXO9T9ldhXaKFXnZ/MgynEq971aAAvzkPCSmTJUtRjmTwdkWpR56LdrdVimMga59+OZJfVfBPWvOZ0fEYB8L6ZTy24kZ46Mb7FBiQGEHckrmLPLXcIkWr2TAFtnmsDgMhpdNBttao16CbTRD2Lwz4ntBRBgbRwVOyf1bTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mqk0y3palnKQ0y9x1gYvNMzP4as8FTu+Gpwq85tb5U=;
 b=c86gGSOTDmdvuaWJlpENSEOjV1TprOnQ0MGrxJNGSCGDepIzN89136Jao0ARlCG7TmRrDxCqx9B4VggFv0aUB4xJPFsBDcnVK8NbgY5jEvwoML2BhoIhRw+FqVN/nVJ767kH6EgQtI6a8M/O1FzaqTIG7pnZLckjs3fa7RKIP55hhxpTXeUagLNqL8XMDgkO8jmEO5YAsjcr0QLdybzMpQ4xp4oDrvz4ymyBm7Spz07IdggvE+Avu8KVBk00435ONuATcvyUS+IQanJih/GonSLczxXxTiHlL+iD7KdHGkgCobzJMwUOcJFkJ1cD/smEqkMf3nP1PYFe3ZkpYRJnnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mqk0y3palnKQ0y9x1gYvNMzP4as8FTu+Gpwq85tb5U=;
 b=Yj5FOsVScR6CfA34D1FDYReCw70KoiS6Za6wCnM/mnf+xvnbOWRUjKW42AicHWam1SehxpFJoif6RceZLN5gpE92FuTD2TcxE6/gz+osYkR5n3AOGKRH1aYoiU3+TWlLKaRpg3dd1ASPOfelNIp15gfZzRzPLIWVMxSGxvbv9GA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4851.namprd04.prod.outlook.com (2603:10b6:208:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Thu, 22 Oct
 2020 10:28:28 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 10:28:28 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        Hannes Reinecke <hare@suse.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/2] block layer filter and block device snapshot module
Thread-Topic: [PATCH 0/2] block layer filter and block device snapshot module
Thread-Index: AQHWp4kz58LitSapJ0yJglx6ktyIVg==
Date:   Thu, 22 Oct 2020 10:28:28 +0000
Message-ID: <BL0PR04MB6514AC1B1FF313E6A14D122CE71D0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <71926887-5707-04a5-78a2-ffa2ee32bd68@suse.de>
 <20201021141044.GF20749@veeam.com>
 <ca8eaa40-b422-2272-1fd9-1d0a354c42bf@suse.de>
 <20201022094402.GA21466@veeam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: veeam.com; dkim=none (message not signed)
 header.d=none;veeam.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:ac62:d981:f824:8ed3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbd8f461-6f72-4259-f33b-08d876753729
x-ms-traffictypediagnostic: BL0PR04MB4851:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4851AE090600A93915414C98E71D0@BL0PR04MB4851.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6qcciEfuddVGkSkKqsFCIOnK8XZO9ClIs4MUACT+59CNSp0e7Fcfyhm1H86GHOk0E21Crus/Zez9mpxLXClKzbLjNs2w16vUunyrDcFIph01Ca6Jb4c633pQGpHLb4hc+VXt1FTbhpOSxMeXxWm0PsYWbUu6mSzl+AApz2TQ+I27ehW0ezNDx+MjSg1ZuTRpPqpNscglw9jsKcg2rJapr10+ELFlA4fWaOJNqj2tEv4ZYPVxh7Az7C9w0xLxUsvQoY0+ALh3Z8NGESUHSV/pENsH3MBszFZ+92rPxSuCCUbRymXLIqsrl2YXr/hdgu5mD6JqE4t1aAWkWPZaKJcc7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(8936002)(6506007)(5660300002)(186003)(9686003)(52536014)(2906002)(7416002)(66574015)(8676002)(86362001)(33656002)(83380400001)(53546011)(478600001)(7696005)(54906003)(110136005)(316002)(66946007)(55016002)(76116006)(71200400001)(91956017)(66446008)(64756008)(4326008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oXQUnX43KKastovtZpvYooBD/l+BG/AUwePS+fsk3p8qbX6HAsbuBS7WcK2YH6W2SG8gCKkhRXpo24P6d2JZXWhLEaJnmwbk+1MoIfo8Kys2x7QM8ZtuEeVmTvYI5dCdinoXeZyk3mCHnVzH6/LPboW4mnlfrhf/PBLBxlqu0TXkWrMffOMxdGKO59AkPMqhwf6N6rVUWWqdzzJXS5ahidLNQF6HOC74KsCNlpEb3XxrudyevTZlYPod/2FDzXWNEdBwd4Ewa8BVh3w0EDpW4boNdTJGyaiH3B+kbAG+XxBR3lZHynis2dmdE3R95OM72mFQw0iv6Te2SHRlpjU3COh6K0f6keszP9xmCV9APPUAxrN1/GJQOHpDtlqvreCFDUeZKjWdYXY0WAt0FHlMhBN5YLEs6bm8nVe2vdlazbmYrHpa+VMuRJDVKHi1VpsMm1CvDd3KallEJRj3PVFgdGzD9rIfqmAf+qnLbEbgRFi4LJjf8HByG04KRe1hUraA/xen7AIvf8+o6i6DE0ES1qogsArK0RfRezEI/Le6CMsqNrqNlk29H81RTxayLAKVbmr8VeqXFN5pPipFXIoDo1t6A5cUy9shgJ28L8Gmtk/f2k9JF6wx0S6MqjsJpvdpuLotoZWjDx5xncJXToXmSF/Hhu28kNvyJdCkWHAtls1Pa7z/F156LhM/lwljdlRusDAPPCgyX2ysBXxANbbKbg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd8f461-6f72-4259-f33b-08d876753729
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 10:28:28.0766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+ZT9P6GPuheyMRlT9UDP+BnHG5ruGpWHjvLNZQdfv2g46dmR5jAELrDp+sW7nMFNva9QLq9+PdQFTzhVHHGYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4851
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/10/22 18:43, Sergei Shtepa wrote:=0A=
> The 10/22/2020 08:58, Hannes Reinecke wrote:=0A=
>> On 10/21/20 4:10 PM, Sergei Shtepa wrote:=0A=
>>> The 10/21/2020 16:31, Hannes Reinecke wrote:=0A=
>>>> I do understand where you are coming from, but then we already have a=
=0A=
>>>> dm-snap which does exactly what you want to achieve.=0A=
>>>> Of course, that would require a reconfiguration of the storage stack o=
n=0A=
>>>> the machine, which is not always possible (or desired).=0A=
>>>=0A=
>>> Yes, reconfiguring the storage stack on a machine is almost impossible.=
=0A=
>>>=0A=
>>>>=0A=
>>>> What I _could_ imagine would be a 'dm-intercept' thingie, which=0A=
>>>> redirects the current submit_bio() function for any block device, and=
=0A=
>>>> re-routes that to a linear device-mapper device pointing back to the=
=0A=
>>>> original block device.=0A=
>>>>=0A=
>>>> That way you could attach it to basically any block device, _and_ can=
=0A=
>>>> use the existing device-mapper functionality to do fancy stuff once th=
e=0A=
>>>> submit_io() callback has been re-routed.=0A=
>>>>=0A=
>>>> And it also would help in other scenarios, too; with such a=0A=
>>>> functionality we could seamlessly clone devices without having to move=
=0A=
>>>> the whole setup to device-mapper first.=0A=
>>>=0A=
>>> Hm...=0A=
>>> Did I understand correctly that the filter itself can be left approxima=
tely=0A=
>>> as it is, but the blk-snap module can be replaced with 'dm-intercept',=
=0A=
>>> which would use the re-route mechanism from the dm?=0A=
>>> I think I may be able to implement it, if you describe your idea in mor=
e=0A=
>>> detail.=0A=
>>>=0A=
>>>=0A=
>> Actually, once we have an dm-intercept, why do you need the block-layer =
=0A=
>> filter at all?=0A=
>>  From you initial description the block-layer filter was implemented =0A=
>> such that blk-snap could work; but if we have dm-intercept (and with it =
=0A=
>> the ability to use device-mapper functionality even for normal block =0A=
>> devices) there wouldn't be any need for the block-layer filter, no?=0A=
> =0A=
> Maybe, but the problem is that I can't imagine how to implement=0A=
> dm-intercept yet. =0A=
> How to use dm to implement interception without changing the stack=0A=
> of block devices. We'll have to make a hook somewhere, isn`t it?=0A=
=0A=
Once your dm-intercept target driver is inserted with "dmsetup" or any user=
 land=0A=
tool you implement using libdevicemapper, the "hooks" will naturally be in =
place=0A=
since the dm infrastructure already does that: all submitted BIOs will be p=
assed=0A=
to dm-intercept through the "map" operation defined in the target_type=0A=
descriptor. It is then that driver job to execute the BIOs as it sees fit.=
=0A=
=0A=
Look at simple device mappers like dm-linear or dm-flakey for hints of how=
=0A=
things work (driver/md/dm-linear.c). More complex dm drivers like dm-crypt,=
=0A=
dm-writecache or dm-thin can give you hints about more features of device m=
apper.=0A=
Functions such as __map_bio() in drivers/md/dm.c are the core of DM and sho=
w=0A=
what happens to BIOs depending on the the return value of the map operation=
.=0A=
dm_submit_bio() and __split_and_process_bio() is the entry points for BIO=
=0A=
processing in DM.=0A=
=0A=
> =0A=
>>=0A=
>> Cheers,=0A=
>>=0A=
>> Hannes=0A=
>> -- =0A=
>> Dr. Hannes Reinecke                Kernel Storage Architect=0A=
>> hare@suse.de                              +49 911 74053 688=0A=
>> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=FCrnberg=0A=
>> HRB 36809 (AG N=FCrnberg), Gesch=E4ftsf=FChrer: Felix Imend=F6rffer=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
