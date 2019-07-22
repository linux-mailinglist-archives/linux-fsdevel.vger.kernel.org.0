Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9957E6F6B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfGVAJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jul 2019 20:09:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5323 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfGVAJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jul 2019 20:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563754165; x=1595290165;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=txiJ9c8LPIECIXuT4XxHAF/OIrjxaZ5nL7nc4REeSXA=;
  b=Rio16usLd58oIpwf82P7mj9B62ZoYNkkz1WUs1GYKdggHhb89CAkCAjE
   G5mDnWroMQQyE+lLZfBoVvarHJUdqX8f5so8QUohC2Y3AyhWbbtwjwnP2
   LX0qOkrgz40ROqepCcqbZfgBJym9FcQMD3C/o7aBRIAnqOMZjbJsftd34
   leB2njbkb0z0//Id/6gc4gsKvy//0BC0Gwh1FqOO51toHhL6b3jH0SqeA
   wHn4iDldkGw06wE3ni14np66F5nvk7BBt/jk1fHKuaLwVT9Jk6N8bPNtC
   D4g8O66OfY9qCY1+PBpiiSBDRNDPumdCSlf7X7IzfYrpB/gZBS7g/yAye
   g==;
IronPort-SDR: Eom4hlDMNzY7baCBQoYWqUn4Db8gXxjhqfxuE43RwLnVxI+2nDwDGGAfXqTQCRs/pqfzvP2Ooo
 RVF6JCdRhRYCGtif82+8iOidMSTVDj8IclIWusgfDylT6vM4OcsvODkcRdFTjelWzHmkgLHWVg
 4XpQ+GP79ReMCwui1wPeDf1aH38BUA7RUogW7Uhc7oSqgt7nSB7AHVT7k5B9o8aO2sUrpV6eVH
 wgGEdsbDwHn80T8/pTiwth390/l1y0oMbA4OmDyIyxFj9bpYukXLZSBeGran++rIl7P5JdNfkd
 kVY=
X-IronPort-AV: E=Sophos;i="5.64,292,1559491200"; 
   d="scan'208";a="113643127"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2019 08:09:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU5nVLHbiKJzlRLAMayENQqXZgjDJgTbGkgUVf7uAf7OB8BDUiP4LP0vSEDw9nVqJ22sB3uYDQVtWTTAmo96RnIN+fUVRZ7YZ1quFIjtDab6RtdZR2s8Z+6OR+EW+Vovf17lC3P66QfKOpPa55O05mYt/EhaH/VtucjQrlUWvWX5nOZzmzUcSj6Jl8IvYP1hcwZiHrPfqsikHo1Kv+v2T1Yc97j5UzhYdOG2dM4vrvUqdokw5CCmvopzjmLx+kIG9lJuaBdzDLdUvidNj2Vgq2FO8dslRHqvHHHf6zh7aR75cKauw0nXEJBzF/lXei/+uDJ06AejdeVJcjHP0HT4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txiJ9c8LPIECIXuT4XxHAF/OIrjxaZ5nL7nc4REeSXA=;
 b=UI52NlqYyVCn/rNhR2+J4LR997E04Sf16RyxwP+K0WvT0jqhmpejeXbPDiIw3WjC13zM43wq4LkirHdte2tPwdbMQuE3vAM9Vnfi8Yr04Hz7CMU0h4AGJ6FLgurqi+3QSEgk4NFGCwvTrirX4rgm99GILQF7bQN5b97efDttwlGzafB58XwjP69OrwrmNfycWsu9plh9FxeHVpuI5bw8IW7JalvaRClO7JMJZ8Go7lSWb7QU8TNhbroBUxU0iQJ8fgoD57x8f+yAKoBo5Wevvc1QUkZVZt4OuJDf+2HrAMojEgbbP9656CuqKsbCXNDvDsb8Kxhnl+uXUiJXy/FbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txiJ9c8LPIECIXuT4XxHAF/OIrjxaZ5nL7nc4REeSXA=;
 b=RLiiYeb8KJLvVYAr5jGOs3DMazqulurjbT2tGjFOoOkI+YzAenj1hrr9DHoqOVEuV++gv6iJSX/ugV6g/fP/CI+gJeZl48XMPGwEv3GE4flRqYY07rQd2m9qbbGiPIjfDlPFcPYszz7BAEiXj54qBSq4/L9NH/g/Jhk7tAqbkgM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4917.namprd04.prod.outlook.com (52.135.232.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Mon, 22 Jul 2019 00:09:22 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 00:09:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Jeff Moyer <jmoyer@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Ting Yao <d201577678@hust.edu.cn>
Subject: Re: [PATCH RFC] fs: New zonefs file system
Thread-Topic: [PATCH RFC] fs: New zonefs file system
Thread-Index: AQHVOF31k+9+55ZdEkmKABdH1mzidg==
Date:   Mon, 22 Jul 2019 00:09:21 +0000
Message-ID: <BYAPR04MB58161B9942C0185E3136062DE7C40@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
 <x49zhlbe8li.fsf@segfault.boston.devel.redhat.com>
 <BYAPR04MB5816B59932372E2D97330308E7C80@BYAPR04MB5816.namprd04.prod.outlook.com>
 <x49h87iqexz.fsf@segfault.boston.devel.redhat.com>
 <BYAPR04MB58164A7ACFD3B6331404ECA3E7CA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190722000424.GP7689@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a4d0467-a9f7-4d09-d9cc-08d70e38d92e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4917;
x-ms-traffictypediagnostic: BYAPR04MB4917:
x-microsoft-antispam-prvs: <BYAPR04MB491772E436224DC2212CA35EE7C40@BYAPR04MB4917.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(174864002)(3846002)(6116002)(86362001)(486006)(52536014)(25786009)(4326008)(81156014)(81166006)(5660300002)(7736002)(305945005)(74316002)(7696005)(99286004)(446003)(476003)(53546011)(102836004)(26005)(71200400001)(6506007)(71190400001)(316002)(186003)(76176011)(55016002)(229853002)(33656002)(9686003)(6436002)(8676002)(54906003)(6246003)(66066001)(14454004)(76116006)(91956017)(6916009)(66946007)(66556008)(8936002)(256004)(14444005)(478600001)(53936002)(66476007)(68736007)(66446008)(64756008)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4917;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9UoA668I0olVUHX6JQj/s3FV4kjHrEKiWkJsS36Hp6iFpO+2OfYbjWK5uNK2ninqf5hVkFlSQpyAACkheHO3mugz09KC22NDPGWwsXn5SAL3tesoZF4XMsyBWRI2MwxlZtOq7LgO2f4L31cLGE5mpDmzREqIFZUtABrpNHNQTAXXkQbD7MbkBuxxaLdESq+VgKMnRanV5Ulcsjf6cTsmWrwPONw2ZVFs+4XOkkz4SJ/WBLaJKHXCWyfxQcNDs6O7FFaNJV6KppDHJnyW8v5AXMSRfIqpa1k+E5XZ1VN0MDhnjk1VUDNxieTQdaGuQm8t5PraKWrNE3niO6qYNCm/NQlxw9o2FfBtk8SHf6dzRguNDQd+hF2DKVyUvReymz10ixNdGWrC6yirvYqDftVpvCvGEQSv4D17Vdq3/8QZIak=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4d0467-a9f7-4d09-d9cc-08d70e38d92e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 00:09:22.0088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4917
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/07/22 9:05, Dave Chinner wrote:=0A=
> On Sat, Jul 20, 2019 at 07:15:26AM +0000, Damien Le Moal wrote:=0A=
>> Jeff,=0A=
>>=0A=
>> On 2019/07/19 23:25, Jeff Moyer wrote:=0A=
>>> OK, I can see how a file system eases adoption across multiple=0A=
>>> languages, and may, in some cases, be easier to adopt by applications.=
=0A=
>>> However, I'm not a fan of the file system interface for this usage.=0A=
>>> Once you present a file system, there are certain expectations from=0A=
>>> users, and this fs breaks most of them.=0A=
>>=0A=
>> Your comments got me thinking more about zonefs specifications/features =
and I am=0A=
>> now wondering if I am not pushing this too far in terms of simplicity. S=
o here=0A=
>> is a new RFC/Question to chew on... While keeping as a target the concep=
t of=0A=
>> "file =3D=3D zone" or as close to it as possible, what do you think zone=
fs minimal=0A=
>> feature set should be ?=0A=
>>=0A=
>> One idea I have since a while back now is this:=0A=
>> 1) If a zone is unused, do not show a file for it. This means adding a d=
ynamic=0A=
>> "zone allocation" code and supporting O_CREAT on open, unlink, etc. So h=
ave more=0A=
>> normal file system calls behave as with a normal FS.=0A=
>> 2) Allow file names to be decided by the user instead of using a fixed n=
ames.=0A=
>> Again, have O_CREAT behave as expected=0A=
> =0A=
> So now you have to implement a persistent directory structure,=0A=
> atomic/transactional updates, etc. You've just added at least 2=0A=
> orders of magnitude complexity to zonefs and a very substantial=0A=
> amount of additional, ongoing QA to ensure it works correctly.=0A=
> =0A=
> I think keeping it simple by exposing all zones to userspace and=0A=
> leaving it to the application to track/index what zones it is=0A=
> using is the simplest way forward for everyone.=0A=
=0A=
OK. Anything more complicated would probably be better implemented within a=
n=0A=
existing file system.=0A=
=0A=
Thank you for your comments.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
