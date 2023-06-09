Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA92A72A114
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjFIRRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjFIRRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:17:44 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Jun 2023 10:17:43 PDT
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8FCE4A
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1032; q=dns/txt; s=iport;
  t=1686331063; x=1687540663;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eI+5eQcFdhTuTixj5xHXRDst56bWOlTaX41UJ8zH1jY=;
  b=Dkh0V9KaHntUQRz+/ljyafAbof0orvqseCeWQgi38HfFrxcGdFJ7v2oF
   bDclYzjap3j+Ycs2kH1koc6K7PNAhMGhosWtg3hL7OWTE04NnmNbvhtRd
   gC/VqoUZJFG5wXVsokFrYFp2FcQyCPjZF1Tcjskc5y6ju3uxbYHSdeeOK
   0=;
X-IPAS-Result: =?us-ascii?q?A0AIAAA0XYNkmJFdJa1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAlgRYGAQEBCwGBXFJzWzxHiB0DhE5fiFIDnWsUgREDVg8BAQENAQFEB?=
 =?us-ascii?q?AEBgVODMwKFdAIlNAkOAQICAgEBAQEDAgMBAQEBAQEDAQEFAQEBAgEHBBQBA?=
 =?us-ascii?q?QEBAQEBAR4ZBQ4QJ4VoDYYEAQEBAQMSKAYBATcBDwIBCA4DBAEBAR4QMhQJC?=
 =?us-ascii?q?AIEAQ0FCBqCWASCXQMBoWIBgT8CiiR4gTSBAYIIAQEGBAWBUQ+dRgmBQgGNL?=
 =?us-ascii?q?oQxJxuBSUSBWIJoPoJiAoErARIBIQKEEoIMIos1BwcGBQaCYoMKK4wAgShvg?=
 =?us-ascii?q?R6BIn8CCQIRZ4EICGKBckACDVQLC2OBHVI9gUYCAhEpExRSex0DBwQCgQUQL?=
 =?us-ascii?q?wcEMgkVCQYJGBgXJwZRBy0kCRMVQgSDWgqBD0AVDhGCWygCBzZGEzcDRB1AA?=
 =?us-ascii?q?wtwPTUGDh8FBGqBVzA/gQgKAiIkokQmGQgwgRCBAsRMCoQIoTYXqVWYFiCnb?=
 =?us-ascii?q?AIEAgQFAg4BAQaBYzoPXHBwFYMiUhkPjiAZg1uPeXU7AgcLAQEDCYtGAQE?=
IronPort-PHdr: A9a23:GuMDXBavulLO00Vonvv+8FD/LTDhhN3EVzX9orI9gL5IN6O78IunZ
 QrU5O5mixnCWoCIo/5Hiu+Dq6n7QiRA+peOtnkebYZBHwEIk8QYngEsQYaFBET3IeSsbnkSF
 8VZX1gj9Ha+YgBOAMirX1TJuTWp6CIKXBD2NA57POPwT4fXjs+q0+mp05bSeA5PwjG6ZOA6I
 BC/tw6ErsANmsMiMvMo1xLTq31UeuJbjW9pPgeVmBDxp4+8qZVi6C9X/fkm8qZ9
IronPort-Data: A9a23:CeW81K0dLZM6evJ7QPbD5cBxkn2cJEfYwER7XKvMYLTBsI5bpzFUz
 GFOX23SPPyKNDf1fdgjPoi0o0kOvpKEyNJqHgNu3Hw8FHgiRegpqji6wuYcGwvIc6UvmWo+t
 512huHodZxyFjmGzvuUGuCJQUNUjclkfZKiTracUsxNbVU8Enx510oyw7dRbrNA2LBVPSvc4
 bsenOWHULOV82Yc3rU8sv/rRLtH5ZweiRtA1rAMTakjUGz2yxH5OKkiyZSZdBMUdGX78tmSH
 I4vxJnhlo/QEoxE5tmNyt4XeWVSKlLe0JTnZnd+A8CfbhZ+SiMa748GBeI+SEpsqSisjcFh2
 e9VuoeSRlJ8VkHMsLx1vxhwCSpyO+hN/6XKZCn5us2IxEqAeHzpqxlsJBhpZstDpaAmWicXq
 aFwxDMlNnhvg8q/xbOwV+1lnewoLdLgO8UUvXQIITTxUq58GcmfHv2iCdlwmzE93OxSHdDkY
 uE0Yho+NS7bMw8XEwJCYH45tL742iagG9FCk3qPuLErpmbU1kl10b7wIPLLddGQA8ZYhECVo
 iTB5WuRKhUbMsGPjDSe/n+yi+vngyz2QsQRGae++/osh0ecrlH/EzUMXle95PK+kEP7CpRUK
 lcf/Wwlqq1aGFGXosfVYjSFkWamnxMnecd1Afwq+TuVxbH27FPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQCDVpXIGRpxEZ/J8VuP1TgpwXwqPnBbEFNUizX3iMRi0UKVF4cL/Lud14WtQVnNL
 ya2QD/Sboj/YOYR3Km9uFvAmT/p997CTxU+4UPcWWfNAuJFiGyNOdXABbvztKYowGOlor+p4
 CVsdy+2t7BmMH11vHbRKNjh5Znwjxp/DBXSgER0A74q/Cm39niocOh4uW8ueh01Y55fKWK4O
 ic/XD+9ArcNZxNGiocqM+qM5zgClsAM6Py8DKmPN4oSCnSPXFberHoGibGsM5DFyRhwzv5X1
 Wazese3BnFSErV80DezXI8gPUwDmEgDKZfobcmjlXyPiOPGDFbMEOttGAXVNIgRsvjbyDg5B
 v4CbaNmPT0FDr2nCsQWmKZORW03wY8TXMip8pcPKLXSemKL2ggJUpfs/F/oQKQ894x9nebT9
 Xb7UUhdoGcTT1WeQelWQhiPsI/SYKs=
IronPort-HdrOrdr: A9a23:zV8MlaGK3VY4ZPNSpLqFR5HXdLJyesId70hD6qkvc31om52j+f
 xGws516fatskdvZJhBo7q90KnpewK6yXcH2/huAV7EZniohILIFvAv0WKG+V3d8kLFh5VgPM
 tbAs1D4ZjLfCRHZKXBkUeF+rQbsaO6GcmT7I+0owYPPGNXguNbnnpE422gYytLrXx9dOIE/e
 2nl7N6TlSbCBAqh8KAa0UtbqzmnZnmhZjmaRkJC1oM8w+Vlw6l77b8Dlyxwgoeeykn+8ZjzU
 H11yjCoomzufCyzRHRk0XJ6Y5NpdfnwtxfQOSRl8kuLCn2gArAXvUjZ1TChkF2nAic0idvrD
 D+mWZmAy210QKWQoiBm2qp5+An6kd215at8y7BvZKpm72JeNtzMbswuWseSGqZ16Ll1+sMip
 6iGAmixsFq5R+splWP2/HYEx5tjUa6unwkjKoaiGFeS5IXbPtLoZUY5149KuZKIMvW0vFvLA
 BVNrCV2N9GNVeBK3zJtGhmx9KhGnw1AxedW0AH/siYySJfknx1x1YRgJV3pAZMyLstD51fo+
 jUOKVhk79DCscQcKJmHe8EBc+6EHbETx7AOH+bZV7nCKYEMXTQrIOf2sR+2Mi6PJgTiJcikp
 XIV11V8WY0ZkL1EMWLmIZG9xjcKV/NKwgFCvsukKSRloeMMIYDaxfzOmzGu/HQ1skiPg==
X-Talos-CUID: =?us-ascii?q?9a23=3AaJlMM2mUnJq6/mWNRuorfMC4TAnXOUD08UbIAW6?=
 =?us-ascii?q?1MkR0ba+EWU6q4Kx/scU7zg=3D=3D?=
X-Talos-MUID: 9a23:yQridgidYs3oOPBpykYgDsMpc8FluYiyCGY3lL4rsOnVbBZrayXFpWHi
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 09 Jun 2023 17:16:40 +0000
Received: from rcdn-opgw-1.cisco.com (rcdn-opgw-1.cisco.com [72.163.7.162])
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 359HGeMJ016148
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 17:16:40 GMT
Authentication-Results: rcdn-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.00,229,1681171200"; 
   d="scan'208";a="2787760"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by rcdn-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 17:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=da7Pfc7fVuCZNS4Uw37X71VSMR49h4KZtJ6k8WRpyJMQf1iPv7/wSDl/GvtOowc/a3vR8BM9rSPchYGrbaVnAjEEgT04wN0AESrlrxhrp6nvDZNLT+I2I40SnWHQj/bXhFeoxGSsNbxtrABxRomL8swQYRUGOxdT0UwtEB57t6sRdfs5A+CNxQWZzHwNqhR71pPWUOJYxAysErVcJ7uBjDySbpJnn0XXE02wwKbIlXG3GDBuoWGsLqPWQN6PmxQcSDzegpqSXBecweyZZybYZLNvB3QaU1h2qv8LQrycrrDHnZa4s0BWu0z9zbwaWcKbEX1H3C6J2Uz/KC8SMNdD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI+5eQcFdhTuTixj5xHXRDst56bWOlTaX41UJ8zH1jY=;
 b=Bi8nLMzolSkAwAbs0hYY6XoU0TZB8/HcSoRCu95DJuI4M2O6lfsCBIbTzcPKJ3CcncMAnFr+eU752BVUHmT5Tu/rRmGkePkX8Nu9Ti2aD6Lu4oc9dLc6vnCdMEa4ZC1ZPyrruVKU3eOQRRf0Kz0YZhrkQK1UuqBODfcy3vyQlzptOpsWPIDKna9cjfrpbgAHJ3QgSVsG8DTwIC00jqct7c8GP/tGK76znFA52rnfsjq7PTvHBELnLgKioCt8M+sFjwcXrOt8xa4G9cg7uq06VuQgbdFBGSRBLZOGuJ1okWWLHxdw+XS7zS7CgahkgywehYOwzn3YL09GVl3pwOI1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eI+5eQcFdhTuTixj5xHXRDst56bWOlTaX41UJ8zH1jY=;
 b=A+DUJ9eSxywMiGo9jauQJW/i9pkMAZaGY5uKYNwCudiJks3BQpIbirqVkRM+Txu58FGWnbDUpyIs7B78n6pZOC0cph2xlu5NKETY+BJs61VjkqY6P7zhQtcPuLWAVzPZxsGclz2SnDR4qz6FH19oDE16XrinRRb8QLf5KStG5C0=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 17:16:39 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::d6a3:51ad:f300:ebae]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::d6a3:51ad:f300:ebae%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 17:16:39 +0000
From:   "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Thread-Topic: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Thread-Index: AQHZmpwNhDd19o/UvkKcR6DrdZh/0a+CR0eAgAAG6YaAAAxbAIAACcwAgAAWrFCAADpvgIAAALqG
Date:   Fri, 9 Jun 2023 17:16:39 +0000
Message-ID: <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
 <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
 <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com>
In-Reply-To: <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|SA2PR11MB5148:EE_
x-ms-office365-filtering-correlation-id: 9081c747-3960-49c8-8fd7-08db690d49af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W52T8+Mnq+YKQQTX95L5VWQEamUqzr0SdsYUCmQNRVYVh42neaszQhvonsdXAyeoraR1BxAa4fi6bZKODJFAEWrLSRQysAax3xbltq5TeeyGfTQLIuw6OwudmlGF1E64BKOkJd9+te/oGaDeduyvsjkspeGLsyJckePLYcltm/gI81+Vjsh3BVOkb8JaVQTBSdUyfDP2cNVDshyKDqkYKGfa6gNFV9uAaSadQjNA6GfUQMXMF3+8zrF/Av60WaHsY+G3r8WtoQv3bJNs2kg7/W7ihQZzSIGFaB9NWncMgISdFZQybxH118NT3x5vuwwfELvlhy/NkOMvX9eYbMZCRAxylf+HICXrx64Kd3JpNbbEo5AqmOkamfDGmAA4b9wTCiOdDzjglsnF0Zoc1CBRdN+71BOxtW/cnbbC4bB0+SwIOepzPFWuUnvEhp4E6qY7EkdxBqPETwDzRD8DWGQugrtvlkwWoa4bKR+jrr3CoyIoJDkA6w/B/V35f0X14Xs1jBtgeoVCW0boMfQxJW1Dc+kYKqevSO6V6fTmPmIVfgkuj0hcyKZ6gGPiyJC62mfmsdJ5mnLICZsyLA1+pcWk4L+ZWKdXx7V3DiuE5+4cRxJ7sEQxj2hGeIB6XXsxSbRS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(66946007)(66556008)(38070700005)(91956017)(76116006)(52536014)(66446008)(64756008)(4326008)(5660300002)(8676002)(8936002)(86362001)(54906003)(110136005)(316002)(41300700001)(38100700002)(478600001)(66476007)(4744005)(45080400002)(122000001)(2906002)(7696005)(71200400001)(9686003)(53546011)(6506007)(55016003)(186003)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B/+l2YAgNuNLYBCoxUFl6WV5cs4xDOyVoHp62KvfYR0BQxvo2nuH/TVWfRhH?=
 =?us-ascii?Q?5FuYEPzPn2TBx3I2qoLRd+VMUYUSCCCSZe86mMrPFOw/QIBUhiC/9PEeHuxC?=
 =?us-ascii?Q?x14k474Rytd5i7iufnMLXLF9jbl555c5iv4yMCBy8SaeyE9JGwWFQTFQmoFd?=
 =?us-ascii?Q?aX2DHSoOp5viJwtV9tQxEI5xwtkzb0FWuqXDlJZpbrWEuSCpIRNC8E4ZVY4y?=
 =?us-ascii?Q?km7rRcTWqZJ3wbWFar6DGPs2PpvOUfeFnqvIl2DPWlW6KcluD/MYToMHv5Uo?=
 =?us-ascii?Q?0KEPI32CaQKyj0OMHuwRsn4YzBLY1JJhiviHK+6eDvz4PsfcWeMuML6Y4aio?=
 =?us-ascii?Q?qfahDgLXLQmzCvffmaUdOJCEQ4Y+qYn47dnDLz2p4e7ubYf4jKBPGIVYZj0Y?=
 =?us-ascii?Q?XyMcDoMMPvO3FsyKb4Da9JL+5g/LzYfbwWO3oxc6S+JtboQkJlnFj1UxYLIS?=
 =?us-ascii?Q?HmoIP3sP/5Pq/70dw3yCO7OsbRyb+V19BCjzKWhyCG2mBInrlO3FOyqiDe8p?=
 =?us-ascii?Q?rJ0Yhb6zstm4Dq9uA1P9xVm8COr3EwWUoFRJ+E3VI3qe/yi9cDRCPKKE/vn4?=
 =?us-ascii?Q?T0Nk+XujdRz5Wslb3Lr15wfmOb6s5DzGVOepp2o7M7XAsV/fiLsDlXusD901?=
 =?us-ascii?Q?Y+fUMt55jL0gdVVdBYGeOVAKyl5gWdixcCS67W26reSI05BzyAQHSJljXwyi?=
 =?us-ascii?Q?oEXmAti/BcmITUafg0MSIGoD2TGjUS2HugPjQYxEVOqreRt8KbuH2Kcn2+/B?=
 =?us-ascii?Q?Y33UuFY+lWC2K0clA/+3C5XUJaiVGvp7O5esfHCV600zOahrU4lvTJUBzv4v?=
 =?us-ascii?Q?kO+ZVa38/3krdCIXyy83jRdyodH9B+SbhCpCZq7OlTNmVp8sJ+srOCAJRbtn?=
 =?us-ascii?Q?prCh6aD3J6bebxv9DqO3bstWZZrx9ldKHhkBdPgHv6v4f39KSYu5/x77LH9B?=
 =?us-ascii?Q?EGVO+ZbWKaMxe0PlVNSStagsXyXsloGDXUUPmM83Er9A/uThu+mp3cTKoVwt?=
 =?us-ascii?Q?MbLLS3nBP6u39PCEngmaXZtTtK4zxeePPXObyWuSN11TNQ8/oST8nx/G3azE?=
 =?us-ascii?Q?RVQUH7SwA01XFKlQlMiKUpwaK+jfETlg1MHAkWlh2n9WVouuIxYxFh7XvcT+?=
 =?us-ascii?Q?kqobMgr73tMVZcy2fd0Btgbf/GAk0mL1Ef5M6kabR2/7Plq0XsMwf51TaA/L?=
 =?us-ascii?Q?lv9qWaPnDSo3F4iUVi6cZq67NtDgCVm9WL1UIDWnKzTNkz6ZtKx5OaW3CY2A?=
 =?us-ascii?Q?YdHZs3CVjjWxFajgIqH68WN7jMycXUv4Hsq/Z2tPK7rOsCZPQHsx+tbYwzcg?=
 =?us-ascii?Q?a3/tPe+OeIYWgLSNhzm55qkKDVISIsj+jBpVkszoKixTFhC1LlK58b7cY7J2?=
 =?us-ascii?Q?vhLFkoxcU3qhJeQp0SZojje0YUbfN6Qu5p7qkO00CKu+856HQBE3DWETVBkn?=
 =?us-ascii?Q?80ZpHU9db1YLXXBg4Lz4iBYzCENBWKrBgeC/pDRAnACWZJJLa42y8A2Qw8Vq?=
 =?us-ascii?Q?RRtqhqZElQG76V746eIsFxrtlVM0GjKGSkwk8QuJlKwqFkTYdlyOascymvrg?=
 =?us-ascii?Q?y92ldR7pzTj1FDdEGbvcCOXusnuNhtHBB24NhTtt4Jo9VKPDsSVjKSTho8v0?=
 =?us-ascii?Q?Wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9081c747-3960-49c8-8fd7-08db690d49af
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 17:16:39.4383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVFvYNSGAddoUWgWW0ULox4JW9aUPhpyZBi9i1R1iQNsPNuKUZYf+v09ThZCULgr3MMQXfmz2s+FSWfS+uOwBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-Outbound-SMTP-Client: 72.163.7.162, rcdn-opgw-1.cisco.com
X-Outbound-Node: rcdn-core-9.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I could switch to my personal gmail, but last time Miguel Ojeda asked me to=
 use my cisco email when I send commits signed off by amiculas@cisco.com.
If this is not a hard requirement, then I could switch.

Regards,
Ariel

________________________________________
From: Trilok Soni <quic_tsoni@quicinc.com>
Sent: Friday, June 9, 2023 8:10 PM
To: Ariel Miculas (amiculas); Colin Walters; Christian Brauner
Cc: linux-fsdevel@vger.kernel.org; rust-for-linux@vger.kernel.org; linux-mm=
@kvack.org
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver

On 6/9/2023 6:45 AM, Ariel Miculas (amiculas) wrote:
> A "puzzlefs vs composefs" document sounds like a good idea. The documenta=
tion in puzzlefs is a little outdated and could be improved.
> Feel free to create a github issue and tag me in there.
>
> PS: as soon as I figure out how to turn off the top-posting mode, I'll do=
 it.
>

Let me know as well if you could do w/ Outlook :). Switch to other email
clients if possible.

---Trilok Soni
