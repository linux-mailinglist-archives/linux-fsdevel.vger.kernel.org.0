Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D294C729932
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbjFIMLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239673AbjFIMLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:11:37 -0400
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898EC1A2;
        Fri,  9 Jun 2023 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2184; q=dns/txt; s=iport;
  t=1686312678; x=1687522278;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KJ00/ZijVmvJHEJjS+wqZ2+J+TK5irNi9rk/Qp9IU60=;
  b=NmuVKQPCnmaBkwY0xyN8rbbcYTBBAjCOXVgSLeHv3Y6qbafYY/FBV8Ox
   oMGvI07KhUFh2RGDQT/aNwsNVBcwsUWfuJOFg3CNLq6Ktdv1EJmWU1MlR
   7xeyxx6ORdYctITs6GJVaOOY/XafKAyCFIUQIrlTC3Yfd2LCUkGocmmbR
   E=;
X-IPAS-Result: =?us-ascii?q?A0ADAADxFYNkmIYNJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBFgUBAQEBCwGBXFJzAlkqEkcEhE2DTAOETl+IUgOLUZIag?=
 =?us-ascii?q?SUDVg8BAQENAQE9BwQBAYFTgzMCFoVeAiU0CQ4BAgICAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQcEFAEBAQEBAQEBHhkFDhAnhWgNhgQBAQEBAxIREQwBATcBD?=
 =?us-ascii?q?wIBCBEEAQEBAgImAgICHxEVCAgCBAENBQgaglsBAYIoAzEDARChMwGBPwKKJ?=
 =?us-ascii?q?HqBMoEBgggBAQYEBYFRD5pwDYJJAwaBFS0Bh1WBZIgmJxuBSUSBWIJoPoIgQ?=
 =?us-ascii?q?gKBYoNZOYIMIo4zhVSJVIEpb4EegSJ/AgkCEUEmgQoIXIFzQAINVAsLY4Edg?=
 =?us-ascii?q?lUCAhEpExRSex0DBwQCgQUQLwcEMh8JBgkYGBcnBlMHLSQJExVCBINZCoEQQ?=
 =?us-ascii?q?BUOEYJcKgIHNjg3A0QdQAMLbT01FB8FBD8rgVcwQIEMAiIknkYDhEICgWgad?=
 =?us-ascii?q?ZYdrHpwCoQIi3yPE4YnF6lVmBYgjTqDc5Y/AgQCBAUCDgEBBoFjOg8sgSBwF?=
 =?us-ascii?q?TuCZ1IZD44gGYNbhRSKZXUCAQEBNgIHAQoBAQMJi0YBAQ?=
IronPort-PHdr: A9a23:9ypVgxKJyeZ6h1WZ8dmcuakyDhhOgF28FgcR7pxijKpBbeH6uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1o2t2qjPx1tEd3lL0bXvmX06DcTHhvlMg8gL+H0EZPWht+f3OGp8JqVaAJN13KxZLpoJ
 0CupB7K/okO1JJ/I7w4zAfIpHYAd+VNkGVvI1/S1xqp7car95kl+CNV088=
IronPort-Data: A9a23:CKlaFKN8R/1WA2HvrR2Rl8FynXyQoLVcMsEvi/4bfWQNrUoh02EHm
 2UWDGnTPqqIZDDxetAlPNzkoRtQscPXn95iSnM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCcaphyFBcwnz/1WlTbhSEUOZqgGPykUIYoBggrHVU/EHl52Eo68wIEqtcAbeaRUlvlV
 eza+6UzCHf9s9KjGjtJg04rgEoHUMXa4Fv0jHRnDRx4lAO2e00uMX4qDfrZw00U7WVjNrXSq
 +7rlNlV945ClvsnIovNfr3TKiXmTlNOVOSDoiI+ZkSsvvRNjj434JkSDdNMU0Z0sBTTuoBV+
 exo5bXlHG/FPoWU8AgcexBcFyc7Nqpc9fqeez60sNeYyAvNdH6EL/dGVR5te9ZGvL8sRzgVq
 ZT0KxhVBvyHr+uzwbmmTuB3rs8iN8LseogYvxmMyBmAVKp2HsmZHfSiCdlw5Qh3i8VgFMvie
 9cheTNEUkrZZRdeEwJCYH45tL742iagG9FCk3qPuLErpmbU1kl10b7wIPLLddGQA8ZYhECVo
 iTB5WuRKhUbMsGPjDSe/n+yi+vngyz2QsQRGae++/osh0ecrlH/EzUfUV+95PK+kEP7AogZI
 E0P8S1opq83nKC2cjXjdw+9kkGthzdMYdtzKMxgzVGp+5Pxsy/MUwDoUQV9QNAhscY3Qxkj2
 VmIg87lCFRTXFu9FCL1GlC88G/aBMQFEYMRTXReHVZZv7EPtKl230ySH4c7eEKgpoCtcQwc1
 Qxmu8TXa187oscR06y98TgraBrz+8CVFWbZCugrN19JAytwYIqjIoev81WetKwGJ4eCRV7Ht
 38B8yR/0AzsJc/X/MBuaLxSdF1M2xpjGGGE6bKIN8J/nwlBA1b5IehtDMhWfS+FyPosdz7ze
 1P0sghM/pJVN3bCRfYpM9zrV5Vylvi9RI6NuhXogjxmPMMZmOivoXEGWKJs9zuFfLUEyPtmY
 s7LLa5A815DUPQ8pNZJewvt+eZ7mn9hrY8ibZv61B+gmaGPf2KYTKxtDbd9Rr5R0U9wmy2Mq
 4w3H5LTk313CbSiCgGJqtR7BQ5RchAG6WXe9pY/mhireFQ2QQnMypb5nNscRmCSt/4Fy7+Rr
 ynsChcwJZiWrSSvFDhmo0tLMdvHdZ1+tnk8eycrOD6VN7ILOO5DMI93m0MLQIQa
IronPort-HdrOrdr: A9a23:srz3+q8iRsfe5FooRS1uk+F3db1zdoMgy1knxilNoENuE/Bwxv
 rBoB1E73DJYW4qKQ4dcLC7UpVpQRvnhPlICPoqTMmftW7dySSVxeBZnMffKljbexEWmdQtrp
 uIH5IObeEYSGIK8foSgzPIXerIouP3ipxA7N22pxwAPGIaCZ2IrT0JdzpzeXcGIjWucKBJbK
 Z0kfA33gZIF05nCvhTAENpY8Hz4/nw0L72ax8PABAqrCOUiymz1bL8Gx+Emj8DTjJm294ZgC
 j4uj28wp/mn+Cwyxfa2WOWxY9RgsHdxtxKA9HJotQJKw/rlh2jaO1aKv6/VXEO0aOSAWQR4Z
 3xSiQbToNOArTqDyeISC7WqkzdOfAVmibfIBGj8CPeSIfCNUMH4oJ69PJkm13imgsdVBUW6t
 MQ44pf3KAnVi8pkEnGlqv1fgAvmUyurXU4l+kPy3RZTIsFcbdU6ZcS5UVPDf47bWnHAa0cYa
 BT5fvnlb5rWELfa2qcsnhkwdSqUHh2FhCaQlIassjQ1zRNhnh2w0YR2cRaxx47hd8AYogB4/
 6BPrVjlblIQMNTZaVhBP0ZSc/yDmDWWxrDPG+bPFyiHqAaPHDGrYLx/dwOlauXUY1NyIF3lI
 XKUVteu2J3c0XyCdeW1JkO6RzJSHXVZ0Wa9iif3ekPhlTRfsueDcTYciFdryKJmYRrPvHm
X-Talos-CUID: 9a23:neuhXW7zgAGtywqlw9ss5ksmJekcWy3nzVTrAhWdWUJYcZjFYArF
X-Talos-MUID: 9a23:ofRoKgg75Ozy3RTx2qBxesMpDfgv7qGAAX0xjYg+q8CvC3JpPT2MpWHi
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 09 Jun 2023 12:11:17 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
        by alln-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 359CBGF4018493
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 12:11:17 GMT
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.00,229,1681171200"; 
   d="scan'208";a="2806108"
Received: from mail-dm6nam04lp2049.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.49])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 12:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD4K40st+QWIF1OHbNw332tmB9hoCzwqC7w6kVqPmAmoq7rozYuTEjXtmihqBA6uM0lUqn8s/7DmzG6zrRBiDU8l5y3jbFCL9eQoJnQctJJyb2ivUCIG0sRWRHt0T5EqIxqLRyuwUso/hzjz8jbkaIqN/6SBMuf1nFVY+kYcuNSbdDKcqmXx3ilaPFTEcCfy85SaMSRAgLTNeUCYxmf2H2BRjjYQrp5R/lB3ydcuoUlFU24FypQd8JLQzX6WteDr3FpTz9kUmxVR3L1SLx0soNriCdxjDBKgChZHJS8E9O9iGDMb1y5b1YNiTETkl5+G3QsDkX52trIsnF9bXImeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ00/ZijVmvJHEJjS+wqZ2+J+TK5irNi9rk/Qp9IU60=;
 b=LBm7MySzdRQtK1lzFuy6S7FxPAH2WqAydhH/vKeO3TaOz58rXWi2QGqSSzHTTuhRqjW0sZ9u+likSILa2JoDPlGPGYh7fDzcY+l2KwdHB/iVReI7oMl3wt/x5jgY3F7eV3jtfAZpDkyAbvsfElxWiFbFRP6WPpJOVtHNyrFrA5H5e3CS9KtiQGzn6xvEwgmMD8ZMFw0hNUD7vhjtlRK1Ji9kfRYbv9KzVN5UH4WSK81gV5T0PQkbt+wsZYERoVS1Nh65Vn65k8d/5AmapFoMA3Hzc+0NpQeFyUdPc8BvVW6adgZbnXFbYjKk12+K76Cfj3+gr7IKID7Re8NIefy0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ00/ZijVmvJHEJjS+wqZ2+J+TK5irNi9rk/Qp9IU60=;
 b=ScuJReIslckwgx+ZGAYR/oAcSQsYjoxjLC0pNizSI0hF7k9h1rPMgl5OaK5rKYCyGiuIcTCnBO7jQHcEpN4RwvJexXFzgGoWKzP2Y8pFORtxeS2PBiDDJOzbchh8kiudS4vzuxhw1eXlOaJ1BVsefTXxeq38D1nUXDO1duYgQ4k=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by CH0PR11MB8214.namprd11.prod.outlook.com (2603:10b6:610:18e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 12:11:14 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::d6a3:51ad:f300:ebae]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::d6a3:51ad:f300:ebae%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 12:11:14 +0000
From:   "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alice Ryhl <aliceryhl@google.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Thread-Topic: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Thread-Index: AQHZmpwNhDd19o/UvkKcR6DrdZh/0a+CR0eAgAAG6YaAAAxbAIAABioAgAAAogQ=
Date:   Fri, 9 Jun 2023 12:11:14 +0000
Message-ID: <CH0PR11MB529931E71B5227AC6C49B737CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
 <CANiq72nAcGKBVcVLrfAOkqaKsfftV6D1u97wqNxT38JnNsKp5A@mail.gmail.com>
In-Reply-To: <CANiq72nAcGKBVcVLrfAOkqaKsfftV6D1u97wqNxT38JnNsKp5A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|CH0PR11MB8214:EE_
x-ms-office365-filtering-correlation-id: 869ad52d-90a7-491e-3383-08db68e29f3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EzZqa/hKeaFDoxKjEt42uZFsBhQ0CpYPmx+5B0D0pNmu3i1LarOhNurKL82SQWYf1++j4DnOt4Cl4wC+yo8VN5z8UcmVNK12U36ebtN6EIpzlujAI/o+xmdOkSPProQZ1sPXe+Qmuk360njsDalSMJHtgGW1R3Phr0aNpvHycVjTlkR9Gs68QCLJ5nTecGIry730+b8cBGTcwcwj42tHtKL4/LC6YyItexcEbYIPFD5yn8qeelrYDj/UrTZLUS/QhSVOP4r4x3+xHLSWy2thEuiiPWchEcwhzlfw4z7OxA2i/ciFpsxenl2HUyX9G953LpUB71qKTAmuKY3SmW6cJ7IN9iCjqr6cZjgkndnfQPvo5U/tYUypXmrMt6a7vjBphYo6RAOU8uYbLHYQvAUUE06zlq3Q90fq/Ckly5J5TQ9tQlZMa9Wgq5jTKTBWneY6m4A7FrswkOoRT2s8HTp/ZxPEK3+0EuNu+SdM669d2l58VExC0x0YvzRp0j+/xZR4AgPQBLmzsybSIFH6VK5BXFr87R4pQ4xwa/JAQQpuhfiPiBRwLm6dI+qV61XWgRAetT06nMW+UVvoae6h50xjkfnsuho5yJhHKMajsJHUeDA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(55016003)(71200400001)(7696005)(91956017)(64756008)(110136005)(478600001)(54906003)(316002)(8936002)(186003)(41300700001)(8676002)(66446008)(76116006)(4326008)(45080400002)(66476007)(66556008)(38100700002)(66946007)(122000001)(9686003)(53546011)(966005)(83380400001)(6506007)(86362001)(52536014)(38070700005)(33656002)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cW5zUjVXTHZMTi9nU0JtZzZCcFhQUk9DV2c4akJ0VGp5M2dIc1VHWEI0T0pV?=
 =?utf-8?B?eDVSSEZTT2tHWDVySWNhMUNWa0psY3dMTGZyRE5rVHRVd2V5d0p6QzdGaTRm?=
 =?utf-8?B?cklyR1ZSZHYyMEVRQ0d4dVBGVGFOaUlMZVN4Vkk3STNhRjJJdmFNb2RzWGkz?=
 =?utf-8?B?Q1BUVjc2YlF6bndLdklKbUlUK282b3lLVlJBZ0VaWjZUbDNmRm5lcTRqcnNF?=
 =?utf-8?B?Wmc5REE0R05oOHkrK0lQczNGZmY4MkdqNExqT2d6cGxiY2ZhSE5TSmxLUzBY?=
 =?utf-8?B?RHhNd1h0bkVDZFNSZnpiQ045V2x6djlrM2wzRHJheE5Rb1ROS1VudlZFQjFy?=
 =?utf-8?B?dEVsRm10ek1sb3YwbFFQWWxpdTZua2VFVnkwZTlZVm8vVFFjUXR3WGJ5N1lI?=
 =?utf-8?B?OXNmZFV2SkFKaEV5enZrbGg5YXhmWEFMajJJSTR1UVZYQ0RRcEZXTXljYjhr?=
 =?utf-8?B?VXJvd2ZEeUJPektZaXZxd2o4aVdSS2lqSUUwRkpsVDQvQSsvRXBBVEJkMnh0?=
 =?utf-8?B?SE04eEhneEdhSDdYT3pmUEZycGR4L05Ta014RGR2QlhacGx5UkkybXh2cTBP?=
 =?utf-8?B?akhETjBOWmVkZGNmY0dIT3M3LzduZklKMzFYbGRPWmpUWmdvNzNDbDdNTUVs?=
 =?utf-8?B?bjQrVUhhS0ZWS1R0TFVpYkw1RHgrQ2NBQjl4QitEeTZsZ1JuZVNMVDUwSkM3?=
 =?utf-8?B?cHR2QU1QVjRWTk1aa2E4TzRVQXNMRWU2NWoxdGdzVDdmMHRtZStQK3laZGhn?=
 =?utf-8?B?eGRTNThtS3B6V3RDSG9tejR4eDZPNWlGbUhpK2x4elBmd21TV2NzNkpUb3RG?=
 =?utf-8?B?cnF2RUlRODZ2VVVWYjlJcm1CR2N6Y0t0cjhrT2E0U2VpTWM0T3d2blNFaDRZ?=
 =?utf-8?B?N05VK1Y5ZHdkM3dRVGJoNzc5TkFDUEY3UlNxejlVOGVKV0ExMUplOVZneCtw?=
 =?utf-8?B?Q3g1RXowMjFSNyszMHFZWVg1b1FVUkFibVd1RWY0N1Bjb2c4c3ZiMFRheTR2?=
 =?utf-8?B?MFIvVy94NlZlSm5LKzR3bkZHQ3NNZTRnNVFVZWxOZVk3T011bEpNdTQveklH?=
 =?utf-8?B?WU10OFFma0xuUlNvQ1NDeXdsQnhaT1Z2RTlTblFzZWcyWnNVelFXalNwanVW?=
 =?utf-8?B?TGNDVTFBNERDaDdxaSsrVEFBRjBwRzlBa2crcWRVM3YrWUdpS0xvSldDWnN5?=
 =?utf-8?B?Zi8wN1I5THpXUnRUS0xjL2tjcC9PcnQzMTNXeWlPVkVTdDlVVi9ENDdHOGNt?=
 =?utf-8?B?NXgrSW1nSUxDTU1SeGFkSUZYL014QzNYVWJ6akp3YVppckNITHFoS09Hb3pl?=
 =?utf-8?B?MkpxbVIrRzc4c3RXbFJXT1pSV05VTmJqcmtSaFo1WTZRWjVNdWp1YjNKcXRC?=
 =?utf-8?B?MGx5MUt6ZzU5ZG1vZzQyUTFXalgraHM0OHdpQ3JIMDhVS3F1S1R4MU5kaU1n?=
 =?utf-8?B?T1U1NTVBTWo1R0lzaU9RVDFJMER6aXBhUVJaQ051R25oclFIMThVWkx6ZXNF?=
 =?utf-8?B?N1N6SEp4S0ZNRFFTcDlJcGV5cHJoY1ZkNFI1TERpZW5XeE9qS01iWDFYdmFy?=
 =?utf-8?B?VEoyMlczdy8yRGo4d2dRNm82OUp0eTUyMmdYK3pzM1dRNE5rN1BWOE5wVmEz?=
 =?utf-8?B?OUVVMzREVXRWNTJCeWhNL3c5a1lwSWxneGFjNjdrUktvRFZtc2Q5QnVMcVBF?=
 =?utf-8?B?SHJQS0ROQ0xjNjRGaFVwa0h0cllrdGFncGtQY0Z0anFwTmt5aVErR2Q1a29o?=
 =?utf-8?B?R2pOaEZzazJ4VzZGeXJRdDZXQm1oUzFxZ1V1R1d5TlplQVJMMnZYQjFQWHAw?=
 =?utf-8?B?M3lIZUJwNS84ZEl0VERVQ1dMc3k3ZkV1QllTaWxJV2lmTyt6UmowTXdDWjho?=
 =?utf-8?B?YnA5Nll1SGQ0VC9jaWtwNllJbWpwMlRucDFJMFk1a0dMOURWTXdWSHozOTZP?=
 =?utf-8?B?N1ZidmxFUnhWVU1TckQxMEwybnZMWXNMV1NrSTg5Sm1adXRnTTBzMDI2ZXda?=
 =?utf-8?B?QTFlSGxRYURjeUNBTDFyVnJQZTFuc1NWdVpURFA2QUxpMHlYUWducUtlMEo1?=
 =?utf-8?B?M3ZYVW14eTFmd2RRQXJVc2NIQjN5ZFZENnNRUytYV0FIZllkVVI0bDJSN2M0?=
 =?utf-8?B?T3dtTjF6MXA4Qlk4T3RYVUwrUDNES1dQMEFCTVJObkxXSnZZMUszM3JpUWts?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869ad52d-90a7-491e-3383-08db68e29f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 12:11:14.6526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxozDr2yb+rqQA8wqIQu6jDiFW8YDs6HdmYYGZiIcy3eXduDDdz/ScHabtzYPVlyg2Pz4hiLvF7NwxzD+hT0rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8214
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-core-12.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

U29ycnkgYWJvdXQgdGhhdCwgaXQgc2VlbXMgbGlrZSBJIG5lZWQgdG8gc3dpdGNoIHRvIHBsYWlu
IHRleHQgbW9kZSBmb3IgZXZlcnkgcmVwbHkgaW4gb3V0bG9vaywgd2hpY2ggaXMgYW5ub3lpbmcu
CgpSZWdhcmRzLApBcmllbAoKCkZyb206IE1pZ3VlbCBPamVkYSA8bWlndWVsLm9qZWRhLnNhbmRv
bmlzQGdtYWlsLmNvbT4KU2VudDogRnJpZGF5LCBKdW5lIDksIDIwMjMgMzowNyBQTQpUbzogQ2hy
aXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4KQ2M6IEFyaWVsIE1pY3VsYXMgKGFt
aWN1bGFzKSA8YW1pY3VsYXNAY2lzY28uY29tPjsgbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5v
cmcgPGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPjsgcnVzdC1mb3ItbGludXhAdmdlci5r
ZXJuZWwub3JnIDxydXN0LWZvci1saW51eEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1tbUBrdmFj
ay5vcmcgPGxpbnV4LW1tQGt2YWNrLm9yZz47IEFsaWNlIFJ5aGwgPGFsaWNlcnlobEBnb29nbGUu
Y29tPgpTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAwMC84MF0gUnVzdCBQdXp6bGVGUyBmaWxlc3lz
dGVtIGRyaXZlciAKwqAKT24gRnJpLCBKdW4gOSwgMjAyMyBhdCAxOjQ44oCvUE0gQ2hyaXN0aWFu
IEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBCZWNhdXNlIHRoZSBzZXJp
ZXMgeW91IHNlbnQgaGVyZSB0b3VjaGVzIG9uIGEgbG90IG9mIHRoaW5ncyBpbiB0ZXJtcyBvZgo+
IGluZnJhc3RydWN0dXJlIGFsb25lLiBUaGF0IHdvcmsgY291bGQgdmVyeSB3ZWxsIGJlIHJhdGhl
ciBpbnRlcmVzdGluZwo+IGluZGVwZW5kZW50IG9mIFB1enpsZUZTLiBXZSBtaWdodCBqdXN0IHdh
bnQgdG8gZ2V0IGVub3VnaCBpbmZyYXN0cnVjdHVyZQo+IHRvIHN0YXJ0IHBvcnRpbmcgYSB0aW55
IGV4aXN0aW5nIGZzIChiaW5kZXJmcyBvciBzb21ldGhpbmcgc2ltaWxhcgo+IHNtYWxsKSB0byBS
dXN0IHRvIHNlZSBob3cgZmVhc2libGUgdGhpcyBpcyBhbmQgdG8gd2V0IG91ciBhcHBldGl0ZSBm
b3IKPiBiaWdnZXIgY2hhbmdlcyBzdWNoIGFzIGFjY2VwdGluZyBhIG5ldyBmaWxlc3lzdGVtIGRy
aXZlciBjb21wbGV0ZWx5Cj4gd3JpdHRlbiBpbiBSdXN0LgoKVGhhdCB3b3VsZCBiZSBncmVhdCwg
dGhhbmtzIENocmlzdGlhbiEgKENjJ2luZyBBbGljZSBmb3IgYmluZGVyZnMgLS0gSQp0aGluayBS
dXN0IEJpbmRlciBpcyBrZWVwaW5nIGJpbmRlcmZzIGluIEMgZm9yIHRoZSBtb21lbnQsIGJ1dCBp
ZiB5b3UKYXJlIHdpbGxpbmcgdG8gdHJ5IHRoaW5ncywgdGhleSBhcmUgcHJvYmFibHkgaW50ZXJl
c3RlZCA6KQoKQXJpZWw6IHNvcnJ5LCB3ZSBjcm9zc2VkIG1lc3NhZ2VzOyBJIGRpZG4ndCByZWNl
aXZlIHlvdXIgbWVzc2FnZSBhdApbMV0sIHRoZSBydXN0LWZvci1saW51eCBsaXN0IHByb2JhYmx5
IGRyb3BwZWQgaXQgZHVlIHRvIHRoZSBpbmNsdWRlZApIVE1MLgoKWzFdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LW1tL0NIMFBSMTFNQjUyOTk4MTMxM0VENUExRjgxNTM1MEU0MUNENTFB
QENIMFBSMTFNQjUyOTkubmFtcHJkMTEucHJvZC5vdXRsb29rLmNvbS8KCkNoZWVycywKTWlndWVs
