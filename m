Return-Path: <linux-fsdevel+bounces-648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942DB7CDCB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75561C20D2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0646035897;
	Wed, 18 Oct 2023 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ONp22F3X";
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="GYA1fN8K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8275515ACE;
	Wed, 18 Oct 2023 13:07:16 +0000 (UTC)
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 06:07:14 PDT
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B6F7;
	Wed, 18 Oct 2023 06:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5728; q=dns/txt; s=iport;
  t=1697634434; x=1698844034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S36GLf7gs9lUZj6Y6REPtD8HI2srWr3Gx+iY0eF/q/Q=;
  b=ONp22F3XcX6UTyrnpuhIV1QABUIl4TMUD69Y05SRSrrzLpsZFPLrH/sT
   IeexpFNMPn35+BPEPquyjgCpYvKbI27HjziIw3PRR6bSl8e+Tv+QMG2BT
   ogBJYq/29PGKTGHcgnJYlX8yz11pOhS7jCv01YbJULhzXU7xgDjOOcdkA
   k=;
X-CSE-ConnectionGUID: A80esMR8Qe6+tbh+6hoj+A==
X-CSE-MsgGUID: 2dESGmFbRLupdVf5swWXdQ==
X-IPAS-Result: =?us-ascii?q?A0ClAAAN1y9l/4ENJK1aHQEBAQEJARIBBQUBQCWBFggBC?=
 =?us-ascii?q?wGBZiooB3ECWSoSSIgeA4ROX4ZAgiMDgRORRIskgSUDVg8BAQENAQExEwQBA?=
 =?us-ascii?q?YUGAocUAiY0CQ4BAgICAQEBAQMCAwEBAQEBAQECAQEFAQEBAgEHBIEKE4VoD?=
 =?us-ascii?q?YZMAQEBAQMSFRMGAQE3AQ8CAQgVAx4QMiUCBA4FCBqCBFmCXgMBpw4BgUACi?=
 =?us-ascii?q?ih4gQEzgQGCCQEBBgQFSbIjCYFIAYgJAYoGJxuBSUSBFYE8gTc4PoJhAoFgh?=
 =?us-ascii?q?iEig3aDG4FkPAUCMoEKDAmBA4J6NSqBFIl5XiJHcBsDBwOBAxArBwQvGwcGC?=
 =?us-ascii?q?RYYFSUGUQQtJAkTEj4EgWeBUQqBBj8PDhGCQyICBzY2GUuCWwkVDDRNdhAqB?=
 =?us-ascii?q?BQXgRIEah8VHhIlERIXDQMIdh0CESM8AwUDBDQKFQ0LIQUUQwNHBkoLAwIcB?=
 =?us-ascii?q?QMDBIE2BQ0eAhAaBg4nAwMZTQIQFAMeHQMDBgMLMQMwgR4MWQNsHzYJTANEH?=
 =?us-ascii?q?UADeD01FBttnUWCaHsTASVaMRRrHB0RlgsBjBSiYgqEDIwBlR5JA4VBowSBD?=
 =?us-ascii?q?y6YDpZWjGCEcAIEAgQFAg4BAQaBYzyBWXAVO4JnCUkZD44gCRmDVoYViWR2O?=
 =?us-ascii?q?wIHCwEBAwmLSgEB?=
IronPort-PHdr: A9a23:coPg/hxROC7XZK7XCzMRngc9DxPP8539OgoTr50/hK0LK+Ko/o/pO
 wrU4vA+xFPKXICO8/tfkKKWqKHvX2Uc/IyM+G4Pap1CVhIJyI0WkgUsDdTDCBjTJ//xZCt8F
 8NHBxd+53/uCUFOA47lYkHK5Hi77DocABL6YANwJ+/oHofJp8+2zOu1vZbUZlYAiD+0e7gnN
 Byttk2RrpwPnIJ4I6Atyx3E6ndJYLFQwmVlZBqfyh39/cy3upVk9kxt
IronPort-Data: A9a23:OX5S/6JlItph7CMzFE+RjZQlxSXFcZb7ZxGr2PjKsXjdYENShTRWn
 WAZWT2FMqqLZjP8cohzYd7lpkxQvZ7VztU2GlAd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcYZpCCea/k/9WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVvW0
 T/Oi5eHYgT8g2ckajl8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKmWDNrfnL
 wpr5OjRElLxp3/BOPv8+lrIWhFirorpAOS7oiE+t55OLfR1jndaPq4TbJLwYKrM4tmDt4gZJ
 N5l7fRcReq1V0HBsLx1bvVWL81xFYQWoLLcBELviMHNjFHMcziyw/JsT2hjaOX0+s4vaY1P3
 fUcLDZIZReZiqfnhrm6UeJrwM8kKaEHPqtG5Somlm+fVK1gGMqSK0nJzYcwMDMYj8VPFuvab
 tExYjt0ZxOGaBpKUrsSIMtgwrf42yiuKFW0rnrPqYcMzG39xjZVzaDhDtSIYcO1dclsyxPwS
 mXuuj6R7gshHMaC0ibA/HW2w+vOmz7rcJwdGaf+9fNwhlCXgGsJB3U+UVq9vOn8hFWyVsxSL
 2QK9Sc066s/7kqmSp/6RRLQnZKflhcYX9wVGOog5UTcjKHV+A2eQGMDS1atdeAbiSP/fhRzv
 nehlNLyDjspu7qQIU9xPJ/Pxd9uEUD59VM/WBI=
IronPort-HdrOrdr: A9a23:LWJuNal3Lmu2SG1406taIQyyk2vpDfNQiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtjwfZq9z/JICYl4B8baYOF/0FHYYr2KnrGSswEIfBeOt9K1tJ
 0QPJSWbeeAb2SS4vyKnTVQf+xQp+VvtZrY+9s2rE0dDT2CCZsQkzuRYzzzeiYZNWw2YabRVq
 DsmfavzADQAUj/G/7LfEXtKNKz3OEj+qiWByIuNloM0iXLpzWu77LxDhif2Tkjcx4n+90f2F
 mAuTbUooG4vd+G6jK07QLuBpJt9+fJ+59mPoihm8IVIjLjhkKDf4J6QYCPuzgzvaWG9EsquM
 OkmWZjA+1Dr1fqOk2lqxrk3AftlBw07WX59FOeiXz/5eTkWTMBDdZbj44xSGqd16NghqA57E
 t45RPei3NlN2KYoM073amRa/herDvynZPlq59Js5UQa/pFVFYbl/1twKocKuZzIMu90vFlLA
 GrZ/usuMq/tjihHi3kl3gqz9q2UnspGBCaBkAEp8yOyjBT2Gt01k0C2aUk7z09Hb8GOtF5Dt
 7/Q+9VvaALStVTYbN2Be8HT8fyAmvRQQjUOGbXJVj8DqkIN3/EtpayudwOla2XUY1NyIF3lI
 XKUVteu2J3c0XyCdeW1JkO9hzWWm2yUTnk18kb7Zlkvb/3QqbtLES4OR0Tutrlp+9aDtzQWv
 61Np4TC/j/LXH2EYIMxAH6U4k6EwhWbCTUgKdMZ7ujmLO9FmSxjJ2vTB/6HsuYLQoZ
X-Talos-CUID: 9a23:D5/qVGHs2LYCy1QBqmJOpBYZAeUfIkTQkjTMKU/7V2ZuSv68HAo=
X-Talos-MUID: 9a23:5q2SJghLkVChRwhsrGTWY8MpbstF2IurJko3tYget/eKaDdvBAeRtWHi
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:06:11 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 39ID6BXS007045
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 13:06:11 GMT
X-CSE-ConnectionGUID: 9d+jYpKMTFKaMH06PccHpQ==
X-CSE-MsgGUID: +Kf5Q5feTwWKwfDCVOlkVw==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.03,235,1694736000"; 
   d="scan'208";a="5251203"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 13:06:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vbj5l8kQ4yKXHs7+FziCfqt3vtAIIREXmVsw6xN11+hs4pZebtqQTpG9IZgRX5eGLXDfkIEmpKaGw0TdCc4g3y21GMJLwKeLdUKgSsAEiHVRyp36vZJMwKfgftFTw/wnhnCdHY7KqrvbsaCD1nUmYEk77alqIDIISE3PAdS8NFTnv4EjJ3IE/6H6nxXH2SWrJGFGucsbkT5EYFCroY+0iVFJXvcAXBs+YD3ckIIQCpsAQjZaPlQSP8SYWoNsXImwdB1dVrlru5nukR6s83zUklbrrrRXxI0f0xsAhe14hi2Ue4klXsAcqHMK2vWP1mYw9ah8EEECx1kGqT6IgxZkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9JCu/NidTmmrhgwctRTZ7nlpmiLBh+UX0+ZuJhJc4c=;
 b=SvUiqP2fSzzSfy/kA88RLbtQHdoTilzb3jaoMUkIuIgxBUkIhjZuqpewlTY4TJa9wTSO1MRnN1vV9Slpg85pxDpobo03qixkEFkTvWuQIcClp/4fvsNkWO7EAYvjONwaplZROqND3JMB8iHHdsPwbkQVFaZ09oEuZiXNVLgH3sOhlORD5hW6mStmqjhN6v1wbjR6q399MR6WgBZaJoG9D6mFqM36Zhk3PgiyQk4vSBbcSjWGg17xLtk62sz3QAwR33cUlgjWGQyVhcWLUEmlkm+gxj+C8pY4H3tYxCzN1EySh/p2mMJ1FCO+v8kNokwDQbBOcG8rZXe4mOb2M/A6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9JCu/NidTmmrhgwctRTZ7nlpmiLBh+UX0+ZuJhJc4c=;
 b=GYA1fN8K0LReSmvZVyKliGdC6Md3MbCL/PFAXj/QbAH0RG4pgnmo48LrT6armSyNTgY+R/9XksZBzcbyz4ka5wGFaSj/g8/XPnOSpVBKjpffVRxvpWViuLzck7E6uq1FNqC2mIKitLmf3xR+28MIqNtZ47p81iGVaak8PlfpaHE=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by SA1PR11MB8521.namprd11.prod.outlook.com (2603:10b6:806:3ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 13:06:09 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::6c6c:63b0:2c91:a8d9]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::6c6c:63b0:2c91:a8d9%7]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 13:06:09 +0000
From: "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet
	<kent.overstreet@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        Wedson
 Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 11/19] rust: fs: introduce `FileSystem::read_xattr`
Thread-Topic: [RFC PATCH 11/19] rust: fs: introduce `FileSystem::read_xattr`
Thread-Index: AQHaAcPc4i2M1EsASUmwgM+UiRg3wg==
Date: Wed, 18 Oct 2023 13:06:09 +0000
Message-ID: <jbhv4sp4ojqbfusbqpwxgi3n2wsnnwxeax7tmdvkewwymbofwi@mqdgc7oym2tb>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-12-wedsonaf@gmail.com>
In-Reply-To: <20231018122518.128049-12-wedsonaf@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|SA1PR11MB8521:EE_
x-ms-office365-filtering-correlation-id: 1b8aad0c-478c-45c7-5c5e-08dbcfdaff12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DjLovFOBg1OH2s+2t9/xNilbaI5wAba7T8jMSE0Qx7gLfhR+iZCQVsN7LKsoO2kE9ycpA4mIVl/w7GfEizTlqQ1JnJPPKaOUX9jo8YPIMvD3+EVh/zko+yuDHdPcHhOrIK4q7+WBgKYcjRCRt+zv05BICbD30YDWSFlWez4TwNyi3YPsmzpSzYRi4+gY5cW10JP6jA0QSkLfewcVVgq+s9FrIw6DiIOQ/LWGPyKjc1H+3wABrKT6Oyzdb+ag/DemCSHyB6/DhwiTwP7Pu+pfDUzUv62DVN11gHNH9TOgHE33vihbRGWY6wIejkN6c7ixNFefuz/cYnweeD4H7kOTF9wxYCc3k3dpkSkJrLp0qhFcR7pxla39uC6lIMYxMDZe5jihkwbVNCvZlOs4lSO8/pbgnTFwu0O+YvBkSHCHBj+fFClRXbL8DtoKbglzegF9+jzh3ht/joyCPadbCxy0o5tfJQr9tMtp5J4a9OSprE5vuddiTZ2COHjhCCDzmjEIUir9+VdAnd+6Webd09mzRX85tui/B3Yz0J/RAOQ6VlU07QmNqYGFLG2O2w105Kd95ktiodcoa02/Pj6SdkGw32lJowg3XMOtNMS1D8Wp7E6LBymV6ww0p7/66FF+kRrI/NQn8uiv216+UM7lo52+dA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(136003)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6506007)(33716001)(2906002)(8676002)(8936002)(4326008)(41300700001)(6512007)(5660300002)(64756008)(54906003)(91956017)(76116006)(66446008)(66946007)(66556008)(6916009)(66476007)(6486002)(316002)(478600001)(9686003)(71200400001)(38070700005)(26005)(38100700002)(83380400001)(86362001)(122000001)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Gf+YB7Bt8+E9t3qq7uTT8FADhr3gwWm9W6IDKqiZRu4LBEtSTOu1nqxOHHe/?=
 =?us-ascii?Q?kz/PqRV4eGn/2Pywzody5Xe2nksT4BYNG6OwdUTc8MPF7iIrp8Vwi706TKnE?=
 =?us-ascii?Q?0At6R1CNtam/iPC6rgESTCR0n23Gcm/QejL1seb2X0yN+LeqtamQHv0JYMcq?=
 =?us-ascii?Q?ahoD7NUwOQk1S3rFKMHFzMql9zdWWdh4Ok1Kw5Atde8EhA5fbdGb14uCecog?=
 =?us-ascii?Q?mtJ/5yI14+gQnaqWzXA9BHMK6puEILSduMjRYYA9ke1NhjLUsla0fH2EMUH7?=
 =?us-ascii?Q?gfRBGUkR7/mppF2pp9OqE7RQePJ6YskyH5GCmcUqrk+Hy6dLNr6+23HoXlBX?=
 =?us-ascii?Q?5e6LwS/kJtwNJD/HMpUrndmarOlsyHRDCQJL+YcU/FMPdOBmy1YQEkh1+u3/?=
 =?us-ascii?Q?K87Vwr9sjzTNjb8iReWDXp4pZC6tMFPnLFBhTsG/Y7dolzbma/hgrzKXKTWe?=
 =?us-ascii?Q?2tx5EzDQboyR0wXfwkjhR9WC8CZrpToawtag9ftBQk+j/QHQiAlJnAs5WH4Z?=
 =?us-ascii?Q?giSauz1mvnLSoRtuuTXa2SUU3tjFacOQgVo9PPbB+JtWk/z+Gpmv8RJurFzU?=
 =?us-ascii?Q?+D34JiTW2e2iDPjU1cbrzmj8I8MTTF6SlqaEFpBZP/iVPTDzlOzcc4Imlh1A?=
 =?us-ascii?Q?BS6T0au9aitEuA2QDqd+REbGF2B1ygfH681ac5RsIAcUAwtePZuMz8aG3/NR?=
 =?us-ascii?Q?f3HV0fYNnpNvfMi06lBuhjkfH5lgZs/bWkdJB7s942cvwz/SUmgdtoOV0GX2?=
 =?us-ascii?Q?dLLzcifUfPI0FMllnfDCCJHbkTn8iA9slFxA/F5SMelRp+8MzzkJ2NA8a/lc?=
 =?us-ascii?Q?TVAqv09yoYkrkmxl4MLhGih8eS1JBA+fNfRagA/q+O/dUtAEu4hCOqgHVK+Z?=
 =?us-ascii?Q?MCjpC5jYCTkKYp/rJZSazcGDQuLosQZSbmvL/5OeFjhTak8hiZc5oxUN6+RK?=
 =?us-ascii?Q?xu0QNvNHdExXBIUToT/9d/gs8W+bVFjDD2zDqOS6vUol5goKaLXLTPatZrju?=
 =?us-ascii?Q?ynwjkOkjqZZ3h+rCCNZGdwCMDbQJM7Ep4/4ah2MitgLAGjQqv1udS5CyDzsx?=
 =?us-ascii?Q?DqFpu8GtDJmbwZZgK6BGn9wAxIrx65h0g0WyXURDtvckekuGT7RrQcxWh8g/?=
 =?us-ascii?Q?fFnnue6cAB7zJBaWClOGPIRkkdMRbtYG5Yn/nirQ8PwhbQ1m/YPVGUOGKYkh?=
 =?us-ascii?Q?+TVvHJXPEV7JCVQtPtk7QVYyIx8UJbP4aKF/lf/W9ajCTQhq5bnUc8w1BEPJ?=
 =?us-ascii?Q?EeAM7Fd4g5pBAj0SelAL53KCnNODsGpqnEg3Un0km8XpbzVCnHXguWUma6fx?=
 =?us-ascii?Q?GMLsHr8wIGcJeQgW3Rr2iYIHdKyljybfyxM2wmB3PpDevhLAlNq+vrz0toU7?=
 =?us-ascii?Q?8kEUUC83oTe3qe62Z9UsYvW17rwFEMnBfmvHrvvPghoR5A0YWQOxt/s7L+oe?=
 =?us-ascii?Q?xyjgiI7RxcvseQORJa2KF8mVqHZr/eLbuGzlKDVxY9Xz3LnKYJc4GJxiXlge?=
 =?us-ascii?Q?xpE80TYbFmOQBsQ8mOX+vzsbOiG1TOw340Ioo1Lm7J6mcEcW8zC9v9UV66AX?=
 =?us-ascii?Q?GTtbcXVmJFq/th41Yi1ORRtEZe7MG7QVQDDhWbuI?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B238D3271DBE014D92711ED5891F9A22@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8aad0c-478c-45c7-5c5e-08dbcfdaff12
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 13:06:09.1773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiczTZ17uwD2Y2XfrIqkKgNaxILOP7Am6rZr3l6GAc+eD9Zb1P0SxXbrTPGfiXd6VZaDWbnSCpKWbCLt3XTkUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8521
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-core-9.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/10/18 09:25AM, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> Allow Rust file systems to expose xattrs associated with inodes.
> `overlayfs` uses an xattr to indicate that a directory is opaque (i.e.,
> that lower layers should not be looked up). The planned file systems
> need to support opaque directories, so they must be able to implement
> this.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/error.rs            |  2 ++
>  rust/kernel/fs.rs               | 43 +++++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 53a99ea512d1..fa754c5e85a2 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -15,6 +15,7 @@
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
>  #include <linux/sched.h>
> +#include <linux/xattr.h>
> =20
>  /* `bindgen` gets confused at certain things. */
>  const size_t BINDINGS_ARCH_SLAB_MINALIGN =3D ARCH_SLAB_MINALIGN;
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 484fa7c11de1..6c167583b275 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -81,6 +81,8 @@ macro_rules! declare_err {
>      declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.")=
;
>      declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
>      declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
> +    declare_err!(ENODATA, "No data available.");
> +    declare_err!(EOPNOTSUPP, "Operation not supported on transport endpo=
int.");
>  }
> =20
>  /// Generic integer kernel error.
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index ee3dce87032b..adf9cbee16d2 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -42,6 +42,14 @@ pub trait FileSystem {
> =20
>      /// Reads the contents of the inode into the given folio.
>      fn read_folio(inode: &INode<Self>, folio: LockedFolio<'_>) -> Result=
;
> +
> +    /// Reads an xattr.
> +    ///
> +    /// Returns the number of bytes written to `outbuf`. If it is too sm=
all, returns the number of
> +    /// bytes needs to hold the attribute.
> +    fn read_xattr(_inode: &INode<Self>, _name: &CStr, _outbuf: &mut [u8]=
) -> Result<usize> {
> +        Err(EOPNOTSUPP)
> +    }
>  }
> =20
>  /// The types of directory entries reported by [`FileSystem::read_dir`].
> @@ -418,6 +426,7 @@ impl<T: FileSystem + ?Sized> Tables<T> {
> =20
>              sb.0.s_magic =3D params.magic as _;
>              sb.0.s_op =3D &Tables::<T>::SUPER_BLOCK;
> +            sb.0.s_xattr =3D &Tables::<T>::XATTR_HANDLERS[0];
>              sb.0.s_maxbytes =3D params.maxbytes;
>              sb.0.s_time_gran =3D params.time_gran;
>              sb.0.s_blocksize_bits =3D params.blocksize_bits;
> @@ -487,6 +496,40 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>          shutdown: None,
>      };
> =20
> +    const XATTR_HANDLERS: [*const bindings::xattr_handler; 2] =3D [&Self=
::XATTR_HANDLER, ptr::null()];
> +
> +    const XATTR_HANDLER: bindings::xattr_handler =3D bindings::xattr_han=
dler {
> +        name: ptr::null(),
> +        prefix: crate::c_str!("").as_char_ptr(),
> +        flags: 0,
> +        list: None,
> +        get: Some(Self::xattr_get_callback),
> +        set: None,
> +    };
> +
> +    unsafe extern "C" fn xattr_get_callback(
> +        _handler: *const bindings::xattr_handler,
> +        _dentry: *mut bindings::dentry,
> +        inode_ptr: *mut bindings::inode,
> +        name: *const core::ffi::c_char,
> +        buffer: *mut core::ffi::c_void,
> +        size: usize,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The C API guarantees that `inode_ptr` is a valid =
inode.
> +            let inode =3D unsafe { &*inode_ptr.cast::<INode<T>>() };
> +
> +            // SAFETY: The c API guarantees that `name` is a valid null-=
terminated string. It
> +            // also guarantees that it's valid for the duration of the c=
allback.
> +            let name =3D unsafe { CStr::from_char_ptr(name) };
> +
> +            // SAFETY: The C API guarantees that `buffer` is at least `s=
ize` bytes in length.
> +            let buf =3D unsafe { core::slice::from_raw_parts_mut(buffer.=
cast(), size) };

I think this is not safe. from_raw_parts_mut's documentation says:
```
`data` must be non-null and aligned even for zero-length slices. One
reason for this is that enum layout optimizations may rely on references
(including slices of any length) being aligned and non-null to distinguish
them from other data. You can obtain a pointer that is usable as `data`
for zero-length slices using [`NonNull::dangling()`].
```

`vfs_getxattr_alloc` explicitly calls the `get` handler with `buffer` set
to NULL and `size` set to 0, in order to determine the required size for
the extended attributes:
```
error =3D handler->get(handler, dentry, inode, name, NULL, 0);
if (error < 0)
	return error;
```

So `buffer` is definitely NULL in the first call to the handler.

When `buffer` is NULL, the first argument to `from_raw_parts_mut` should
be `NonNull::dangling()`.

> +            let len =3D T::read_xattr(inode, name, buf)?;
> +            Ok(len.try_into()?)
> +        })
> +    }
> +
>      const DIR_FILE_OPERATIONS: bindings::file_operations =3D bindings::f=
ile_operations {
>          owner: ptr::null_mut(),
>          llseek: Some(bindings::generic_file_llseek),
> --=20
> 2.34.1
> =

