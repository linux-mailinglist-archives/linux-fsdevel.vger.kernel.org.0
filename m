Return-Path: <linux-fsdevel+bounces-11515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A2D85437A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 08:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E655A1C2162F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61744125A1;
	Wed, 14 Feb 2024 07:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l498qNAu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TIOp/R7p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F2111AE;
	Wed, 14 Feb 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895981; cv=fail; b=a0yyjSFJBjDFRbZmf2wWkIITmOpkOL0C1FQmNdjj1m/pZt8TpJrWKepY0vlQq30zU4MPyzi0JGZvATXI8lRpPhyPiBnglkNTXiicvvZG2ohQEAY3IxsAG1XnZPkP/38hopFg/nTBpN5I7aModJc4Yej7CwvD1dWSMr1MfRcOk5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895981; c=relaxed/simple;
	bh=/vGCJY8Fpy451DH/ZM5DZCWVVV6tTiuXfRuIKJCCr2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nPR6zF2V+zYUN6++wsUNCunSTjhWAZApVsh1QFAJYRDTVcMSP3MoRk1SpykZWqvvY/RmS9zzalpy1KNT7esDUtUAqAuNb34ScXtZt/cxlPTvjbdwuUr151v6MFLXqylDXAdvbKkwGKOU4fP892WrlSDnZam/cLdj3WxccnT+u6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=l498qNAu; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TIOp/R7p; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707895979; x=1739431979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/vGCJY8Fpy451DH/ZM5DZCWVVV6tTiuXfRuIKJCCr2Q=;
  b=l498qNAudam8BxFxxnquKEKFphUunGnDVKIs8mC8oysqPTDTgNsus6kE
   p+yAMHdUZl7PRsAbPplqu8fkkafbfloESRhDRWKXG4DG7gkX+8KlaaI3Z
   kYbX9PLSGzr98/PbxRxg1zgMjbKYbARuy3md9T7N8sPaS4WtH8mexuoTj
   6ODHtKgm2mYvGDXLZ40wwK017DMghazWT+zP0m52uS6cWScjpHCsM0D+5
   iF/IFv5JcZcWbKFlCHpjfbJz9NdCTIG8KW5M+7DzfL3vXHpLwIOVhxSQe
   eeIQ6i35CWYhsgbGhr2ER17ilxGguAxfw4iLq0tyXfpEnGPA3hmlceq+v
   w==;
X-CSE-ConnectionGUID: TkWRMCZxQjWyyNHM8CbOhQ==
X-CSE-MsgGUID: hS3K7g3iQ2+R1tawE+1ouA==
X-IronPort-AV: E=Sophos;i="6.06,159,1705334400"; 
   d="scan'208";a="9461346"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2024 15:32:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRKsDkBOcD+a8TF+x/JT4XpCFfW3gSklSCM45e1c57ckL9X1Rm75JmZl4D/fZGxESvqivItiwGUIpOiWsIoP/9g+oEIFNdppHVTBGWKsSaI+Ui4aba+JRIkBjVbY2Osobd3tfu6TeuaUrHIBbyOOG6tIdhW7kMOInLRe0glR8OR2f4yDKK8v66Nu9iYMQ9bwrq/fKsgz/zYT279oTqJzz9xpd12cQFKjpXjzOIWCINX3Jjp7E1ku1Is/+r6/L7RYWHL0/W996msoRV2CPU9q3eUQT6A0zo4Ce1dmAbebSLWndwT9QL2FmNhs5cwnnicTU4xdDDOk04neFfp0JJoFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH44Fee2cqu79koowBX5Ks/IPnVrtPyk3v950gxBo2Y=;
 b=eOBhm0H109wMVIfu479v26LYb0zPqYmMLDVaseZfaMb4vXNUUtmuMyzkUenGhTPgdx40k++mU6gdc2PKvcm+GvxH2sfyFABFuKmxMYd56y8TPYI1sYCxDNgIJhEvBRtLzMDy8rqqN8fWIo7aC0hIw99TvIwz0vtQiYHqM9oCaFWYFFjUQLp5DoIk//GaD9Xn/D+ZJSUX152UrG+HOogoMfKAEtYh77KDaQfDuXsNnznsIF/7ssI9UaJwAVtTumw1KDfT0xN9ybEg+LOOQzQWWGbzAOJuffe58yeDTFoKBBzD3gbWZwGyk/vKvqWDR3gIt37cvDZ+G6lE0gzaoHFe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH44Fee2cqu79koowBX5Ks/IPnVrtPyk3v950gxBo2Y=;
 b=TIOp/R7pNCXU+ZH+pjrJKCnxuxCUVo4q3CwDslAqeWDAyr+ex3wbE75mDr3A4ZBQURewGoWxFS/A5wjdAgIctNeJRZSJ3PzERlWu3cmktHZS9kIULMC3Jrlz1uQvLCPe++NXl+jKmHxE3lV8OSdveu6jg+/roo22FXaTyuQ6YIk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7557.namprd04.prod.outlook.com (2603:10b6:510:58::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.39; Wed, 14 Feb 2024 07:32:49 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 07:32:49 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org >> linux-fsdevel"
	<linux-fsdevel@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche
	<bvanassche@acm.org>, "josef@toxicpanda.com" <josef@toxicpanda.com>, Amir
 Goldstein <amir73il@gmail.com>, =?iso-8859-1?Q?Javier_Gonz=E1lez?=
	<javier@javigon.com>, Dan Williams <dan.j.williams@intel.com>, Christoph
 Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke
	<hare@suse.de>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, "jack@suse.com" <jack@suse.com>, Ming
 Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o
	<tytso@mit.edu>, "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Thread-Index: AQHaXxgCJqc92y55YEmcTzTFLc4Zaw==
Date: Wed, 14 Feb 2024 07:32:49 +0000
Message-ID: <23fhu43orn5yyi6jytsyez3f3d7liocp4cat5gfswtan33m3au@iyxhcwee6wvk>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
 <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
In-Reply-To: <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7557:EE_
x-ms-office365-filtering-correlation-id: b41a7a67-9a34-49c8-b30f-08dc2d2f253b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lHEbcRPVS85TUkUPZZS+CKKEGhPCwcC68JyfBeKDcHamoSDTpTlnunFYzIXPBGcly9xdltDAIB9vDDvwLna/3W67Yl+esF0JwuOItR0ff/3BhY6HqRYEs4Pb6WUQoorMKfCNF7E698HoSKCeCaQKNqx49p00Ww+eu4ly2XdOT4+3dv+apYuRDeCB724KLhGLIEi+BhS8lca6VDzHPx0gHIuuU9cEyHa+ootplqObG1Firsc1qPdg0aMnMo0JIq3Xn9Gu6T3FXWUgaMJzgAFSZ3u3qEqbQHETu6zKjnHcd1odelXeBp1DagmvHHCwzrwNw3eWbXZXpCpPl7olzUPAoHI8BUwlIW8RLsOyxO8uNpMAmaAXHh+GvvPUzJRP8gwtS+MqwCvoX3ZcEM4RLEiTwESjlLtmqNxKK3Bsuc1Nn3M7/szNdjUoft6mH7JWQRSCEYj1653NKKYTGbAgOl7ipRkXIDt9UvFws9ZiBulNkt+bRjmRZAv/MuIRfMRKUL0C/Uc6v50xO05TOgJYgHXp25J2WjWVCyijwlxvUrLvIEuRBEHQeDDjp9VqhhqWqamzQC2PYITiP7r2wTyfVUEjZwQB/NBS3hl8+siKwFfmIaI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(33716001)(44832011)(2906002)(41300700001)(26005)(64756008)(478600001)(6916009)(38070700009)(7416002)(71200400001)(966005)(54906003)(4326008)(5660300002)(6486002)(66946007)(9686003)(8936002)(66556008)(66446008)(76116006)(8676002)(6506007)(83380400001)(6512007)(66476007)(86362001)(316002)(38100700002)(82960400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qGzPeSxTE1HesAeKvD1O/PSAMQtE2laa5pPqbpd23jNIPkHw+hlWUCguh0?=
 =?iso-8859-1?Q?rOnwJiV4ORwF3JNthRLb38O758a1+WYvZcL8crQU0AWUD9KbKCFdi6p6n3?=
 =?iso-8859-1?Q?a8Tb9dnbfO2vZFfREtBP+40jAU0+D2m4bBEtXWw9lSqhMrcair59lFvhc0?=
 =?iso-8859-1?Q?iEVBqFtPNAKrDA69xZSnust2Inhp202i0eukubBiBrtbP/tPnlYCG9Mvlw?=
 =?iso-8859-1?Q?ym1wB4mp1cJw0g0vyDHU/7kfVXq9EyKfL6/IFREY8t8bFhsyGJDC38/YPQ?=
 =?iso-8859-1?Q?RCJxVLKfwhQXmb/VmSnaXlmsJIOfxI/gJZGxB5JDfE+c5IFGB7gW8ripA3?=
 =?iso-8859-1?Q?ZvBz9QrhKbQJiYMsu8LDTylZK0bUhRWQZpDCBsa4wLz7T+cH87A1926Tpy?=
 =?iso-8859-1?Q?3vHBk6RuaDuFcnNvrq8Zvc1kCTpPp3NyruCRwRnnKNS8DOuWAKhFb2wNQY?=
 =?iso-8859-1?Q?GuOaVg/v39gfTIcd7We2j1LDVjEp3qqJjhDXfQDr3nhFw4XB72dq0XOoZz?=
 =?iso-8859-1?Q?ggHUjojJs4hayhFwgeEaGnCmmWUncLU+4QBk9VEXw+3foX8foL4paM4TEZ?=
 =?iso-8859-1?Q?cYZA2NEcOaXMsM0hvfOWBLtSW4i6+9PdpfFqGLu9l1LHRZvW8hbgr2XPa7?=
 =?iso-8859-1?Q?+QUFEdb6AxuIR0yA1xU4/Fy74Hz1BDugnQTRdTyvSg8CWQhw4CVQN5p8cf?=
 =?iso-8859-1?Q?FB3CLGMxckqMlUGp6NW1gXWqA451fCBa4x/wT6ZqNzMO8lT079nEJXtyu5?=
 =?iso-8859-1?Q?K+IqCMy5Ien+pAL7phQnUM7j4k8BBJAs5VlMwQI/Dme5JMLG9sFR42l/h5?=
 =?iso-8859-1?Q?uVXGtUhy5YgnVHexEaabOkNOKQpWEcbRrDOPf26MWA1tXarkht7/VQx0WJ?=
 =?iso-8859-1?Q?Ibgw6GkdYWmhoONysE5HIJ75GP/NpdO7ZG42brslDB7vqHVHVXfRGvTWme?=
 =?iso-8859-1?Q?gboO4fY7Ov8qvvL72Jr1M/Hxfnv9a+V20y+82uRSY959g4kGLrDwWSZZKb?=
 =?iso-8859-1?Q?TXRVRuXX12pjHLBlhH8T5VNfPYnISCTB/tqtADHwRzG6qKwW1Ojnxq2cbC?=
 =?iso-8859-1?Q?2Htp8nX58OqcMyQWyeiA2pazBrS2PTnbKA3h+42pVitFPgnxpGHaI5VqF3?=
 =?iso-8859-1?Q?i3z+jEVnhzUUw8L4BxQECsp0ccW7HN2zyNsftfCGaRqdgnyOz+gzxSwW3P?=
 =?iso-8859-1?Q?XaVo5LQX9FCmu+86qfnlC5t46gSLRea2fXJJsizvIhOHdCHsIR6E2lCqrl?=
 =?iso-8859-1?Q?Y2LmgRaTPET84fPPHKoqlmSZ5ft25u6zlFtukEPeLkoPuvDXn1dMv8vTlR?=
 =?iso-8859-1?Q?VNfDg/1C0Ll4xe1nq5fV2eqglDESJrD/xZMPYVch35FbWDEhXSpnShS0YT?=
 =?iso-8859-1?Q?WLoSFIQuABgZrzcyegqw7Le2CSwNCBX3OxDs5oW7x7U/apbyNsvrc1PxiV?=
 =?iso-8859-1?Q?oVrCBGtP/R7O+bhGCvCqsv3m9ePGhqRAf1vV+UzG5uBEtrYO+1KbtrYjqj?=
 =?iso-8859-1?Q?gMDRv3rgmTq2I2rMwZWHUH3GfTk2HT1pgZPKTcZxfxrOvfGrWVFkzWQ/2G?=
 =?iso-8859-1?Q?yCBz78wc9livG7Fi1k4+BI0NIMNDSg730bi1lRaYrPoF1/F4Vu7WF+cgla?=
 =?iso-8859-1?Q?dlf26oTwED8lRwmFyYN6sG9pc4vhXOSNc0F8MgoiyzkyH9YM5WTYhCG3LP?=
 =?iso-8859-1?Q?vqY9UfpisLONH9JXWkI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6A13BC1F8ADC9448AA4F2C12585A494A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LkXBHFJV1OFyeJs91AYeiovAw2nXl5fqyzN7lE8yeVCAt/hstWF0myOidVebVKsM2t59VxOUpgWyW3trD2k6RKAvm2O702bnP3xoeACNEFDp80hgilSsWCmA1yiVhjq6KRmU6lltcXO1UrDBrRzC1qYgVshCQD2axqctf+TLIIY4O3xczklJDQ7IDFLSz8Aq2+Z+e7MgjjFdUVsWLu9HxKYhsox0v/aZ3TN/9+MDF+zri94FY6FDHTtXuDwENV3XlKBw81Cf8UyQdIq5a5Oij3h83RobE1dQwuTndF3euDVXnynU0W/Xl6mJkaYYsoSTGBbO49SlOgze5Y4OZCmo0wf/+HXlGrp6p47rA/HzXpzy7dQoiaHdMqETURIOFjJLPt8NGihcm6fYGOxUHvurmMn9DkPCgvSUc2Ok6MyydfPkLi7mTXO4mOQCeTVPwgxOnMydWyEQAT2pEXzn6ajaj+JyWx/8IJoTh8fXOC+2RhUzd8nD/Z0H9k+LHqynacxMiseydAuskepH3u/NPu+LlzbRYaOKf5prrSybJl8xsIUTEvTJegvSjugHKdPztHEHoTvYhsc6Bbwlxr8F8OnBFf8Z0y3gGxOZA3HezmE9SJc6fHvsqI1faigN/fGN+5gG
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41a7a67-9a34-49c8-b30f-08dc2d2f253b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 07:32:49.0597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zVKyF7zTp1f/mqmsXFUjCNvnCqfEhzFTzLmGRlIgnKralodn4yqbAqPD1gMyeVCBTg77lVtXoA2lnrWbwrVnK97rK8IjTno8lDBCVajj+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7557

On Jan 23, 2024 / 16:07, Daniel Wagner wrote:
> On Wed, Jan 17, 2024 at 09:50:50AM +0100, Daniel Wagner wrote:
> > On Tue, Jan 09, 2024 at 06:30:46AM +0000, Chaitanya Kulkarni wrote:
> > > For storage track, I would like to propose a session dedicated to
> > > blktests. It is a great opportunity for the storage developers to gat=
her
> > > and have a discussion about:-
> > >=20
> > > 1. Current status of the blktests framework.
> > > 2. Any new/missing features that we want to add in the blktests.
> > > 3. Any new kernel features that could be used to make testing easier?
> > > 4. DM/MD Testcases.
> > > 5. Potentially adding VM support in the blktests.
> >=20
> > I am interested in such a session.

Thanks Chaitanya, I'm interested in them too. I can share my view on the cu=
rrent
status of blktests.

>=20
> One discussion point I'd like to add is
>=20
>   - running blktest against real hardare/target

Agreed. I guess this maybe meant for real RDMA hardware, which was discusse=
d in
a couple of GitHub pull requests [1][2].

  [1] https://github.com/osandov/blktests/pull/86
  [2] https://github.com/osandov/blktests/pull/127

Another topic I suggest is,

 - Automated blktests runs and reports

Recently I learned that CKI project runs blktests regularly against Linus m=
aster
branch and linux-block for-next branch, then makes the run results visible =
on
the net [3][4]. Now I'm trying to understand detailed conditions of the tes=
t
runs. If we can discuss and clarify what kind of run conditions will help
storage kernel developers, it will be a good input to CKI project, hopefull=
y.

  [3] https://datawarehouse.cki-project.org/kcidb/tests?tree_filter=3Dmainl=
ine.kernel.org&kernel_version_filter=3D&arch_filter=3Dx86_64&test_filter=3D=
blktests&host_filter=3D&testresult_filter=3D
  [4] https://datawarehouse.cki-project.org/kcidb/tests?tree_filter=3Dblock=
&kernel_version_filter=3D&arch_filter=3Dx86_64&test_filter=3Dblktests&host_=
filter=3D&testresult_filter=3D=

