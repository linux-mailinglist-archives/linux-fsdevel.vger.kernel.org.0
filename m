Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B6972A2B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 20:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjFIS7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 14:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFIS7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:59:19 -0400
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0AA3A80;
        Fri,  9 Jun 2023 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1606; q=dns/txt; s=iport;
  t=1686337157; x=1687546757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T6OKsS4JnLMNorF2XyocvOKPvkROmOaO0uvzyDiBIKM=;
  b=aguW/9Rx+F75CzDVRUeiKjMrHEETrROHqbjIJczktEpG5aByxF0cw62a
   55tP42nQaDwGvPPaAbICA8D/TBmQdSa/77efsVbb1vnVWw2RbTlwhE5ua
   4MvAprpzUc4A6QM0Ag2+CzDcfOmVcRpS+b0l5ti3RYX/jxSaTh3eh1H+1
   k=;
X-IPAS-Result: =?us-ascii?q?A0ADAACadYNkmIYNJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBFgUBAQEBCwGBXFJzAlk8R4gdA4ROX4hSA51rFIERA1YPA?=
 =?us-ascii?q?QEBDQEBPQcEAQGBU4MzAoV0AiU0CQ4BAgICAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQcEFAEBAQEBAQEBHhkFEA4nhWgNhgQBAQEBAxIoBgEBNwEPAgEIEQQBA?=
 =?us-ascii?q?QEeEDIUAwYIAgQBDQUIGoJYBAGCXAMBEAahWwGBPwKKJHiBNIEBgggBAQYEB?=
 =?us-ascii?q?YFOAw8vnRcDBoFCAZFfJxuBSUSBWIJoPoJiAQEBAYEpARIBCRgCMINiggwii?=
 =?us-ascii?q?SSCGA0LgmKDCow2gShvgR6BIn8CCQIRZ4EICGKBckACDVQLC2OBHVI9gUYCA?=
 =?us-ascii?q?hEpExRSex0DBwQCgQUQLwcEMgkVCQYJGBgXJwZRBy0kCRMVQgSDWgqBD0AVD?=
 =?us-ascii?q?hGCWygCBzZGGxA3A0QdQAMLcD01Bg4fBQRqgVcwP4EICgIiJJ5mA4NxVQKBM?=
 =?us-ascii?q?B1lAcRLCoQIi3yVOhepVZgWII06mjICBAIEBQIOAQEGgWM6D1xwcBWDIlIZD?=
 =?us-ascii?q?44gDA0Jg1KFFIpldQI5AgcLAQEDCYtGAQE?=
IronPort-PHdr: A9a23:UzFrVRcLnl/G+PtEbqwBbdaOlGM/fYqcDmcuAtIPgrZKdOGk55v9e
 RGZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NBsdA97wMmXbuWb69jsOAlP6PAtxKP7yH9vbisW8yuS74LXYYh5Dg3y2ZrYhZ
 BmzpB/a49EfmpAqar5k0wbAuHJOZ+VQyCtkJEnGmRH664b48Mto8j9bvLQq8MsobA==
IronPort-Data: A9a23:/gs/uqp/8WREP2th2URsLiRWTNleBmIsZRIvgKrLsJaIsI4StFCzt
 garIBmBOP6JYjOjfNt+Oo++9x5Xv5Hdn95iSgNtqi89QSoX9uPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7xdOCn9xGQ7InQLlbGILas1htZG0k8EE/NtTo5w7Ri2tAw0IDja++wk
 YqaT/P3aQfNNwFcagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDf3Zw0/Df2VhNrXSq
 9AvY12O1jixEx8FUrtJm1tgG6EAaua60QOm0hK6V0U+6/RPjnRa70o1CBYTQRxRqBSRtfl28
 v9mhISBYAZyDqOQyetIBnG0EwkmVUFH0LbDJX76usuJwgifKT3nwu5lCwc9OohwFuRfWD4Vs
 6dGbmlWKEnY24paw5rjIgVors0mLcL2OIoEknph1jreS/0hRPgvRo2TvIIBhGZh158m8fD2Y
 tsXaCRFTSj8OyYfChAuGaMgtf6lryyqG9FfgAvF+fVoi4TJ9yRrzaPxddTSYJmORMNIjm6Gq
 W/cuWf0GBcXMJqY0zXt2natgPLf2C3gVI8MGbmQ6PFnmhuQy3YVBRlQUkG0ycRVkWa3X9ZZb
 kcT4Cdr9PJ0/02wRd67VBq9yJKZgvICc4FWMMwiwiiK8ID/0h6oL2lffjAdOdNz4afaWgcW/
 lOOmtroAxlmv7uUVW+R+9+oQdWaZHh9wYgqOHNscOcV3zXwiNpp3k+TEr6PBIbw34OoSGCoq
 9yfhHVm74j/m/LnwElSEbrvrDu2opHPQmbZDS2IAzr5tWuViGNZDrFEBHDS6fJGaY2eVFTE5
 SJCkMmF5+dIBpaI/MBsfAnvNO/zjxpmGGSD6bKKI3XH32j1k5JEVdsOiAyS3G8zbq45lcbBO
 Sc/Qz956p5JJ2eNZqRqeY+3AMlC5fG+RYq/CqGMNYoTM8IZmOq7EMdGOxX4M4fFzRhErE3DE
 czznTuEVCxDUv03kFJauc9EiO9wrszB+Y8jbcmrk0v4uVZvTHWUUrwCeECfdfw06bjsnekm2
 4g3Cid+8D0GCLeWSnCOqeY7dAlaRVBlXsqeg5IMKYa+zv9ORTtJ5wn5m+1xIuSIXs19y4/1w
 51KchUAmQej3ieceFvih7IKQOqHYKuTZEkTZEQEFV2pwHMkJ42o6c8im1EfJNHLKMQLISZIc
 sQ4
IronPort-HdrOrdr: A9a23:BdvxkKtsAxCmaiFoA1yrqNwc7skC2YMji2hC6mlwRA09TyXGra
 GTdaUguyMc1gx/ZJh5o6H+BEDhexnhHZ4c2/h3AV7QZniZhILOFvAs0WKC+UytJ8SazI5gPM
 hbAtND4bHLfD1HZIPBkXWF+rUbsZe6GcKT9J3jJh5WJGkAB9ACnmVE40SgYzBLrWJ9dPwE/e
 +nl7J6Tk2bCA0qh6qAdx04tu74yuHjpdbDW1orFhQn4A6BgXeD87jhCSWV2R8YTndm3aoi2X
 KtqX242oyT99WAjjPM3W7a6Jpb3PH7zMFYOcCKgs8Jbh3xlweTYph7UbHqhkF3nAjv0idprD
 D/mWZlAy1B0QKXQohzm2qq5+DU6kdq15Yl8y7AvZKsm72geNtwMbsxuWsQSGqo16NnhqA87E
 qOtFjp7aa+ynj77X/AD9SkbWAYqmOk5XUliuIdlHpZTM8Xb6JQt5UW+AdPHI4HBz+S0vFtLA
 BCNrCU2B9tSyLTU1nJ+m10hNC8VHU6GRmLBkAEp8yOyjBT2HR01VERysATlmoJsMtVcegI28
 3UdqBz0L1eRM4faqxwQO8HXMusE2TIBRbBKnibL1jrHLwOf3jNt5n06rMo4/zCQu1D8LIi3J
 DaFF9Iv287fEzjTcWIwZ1Q6xjIBH6wWDz8o/sukaSReoeMM4YDHRfzPGzGyfHQ0cn3KverLs
 qOBA==
X-Talos-CUID: =?us-ascii?q?9a23=3AH5t/SGvEp5z5Ef38HCoOHn6K6It+dF781F35JHW?=
 =?us-ascii?q?SIldxeZSUEm+epPJrxp8=3D?=
X-Talos-MUID: 9a23:6wglaQpRn/V9LeQLeQkezzRzOsZ2yYWSNBg2waVBgti1KwVpNh7I2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 09 Jun 2023 18:59:11 +0000
Received: from alln-opgw-5.cisco.com (alln-opgw-5.cisco.com [173.37.147.253])
        by alln-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 359IxA5r011589
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 18:59:11 GMT
Authentication-Results: alln-opgw-5.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.00,230,1681171200"; 
   d="scan'208";a="2822595"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by alln-opgw-5.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 18:59:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsAR/vJQwRSKLb4JdxAyH/HndNlDU8JJ+BpZ+ZRexNVL+yEts4/EZf0dZD/2v/l7SB47M0e5sEOKwFfUBT91l5M3/Bq8XxIT8qesGHwWGctCBU1UAQ4hupYU9+rkz9s5k0ASa11uQWN1SD5MJl2eHLTgV4FAKY6v6/ScsUh5DF+df0ousTAmXmPBz8+TI2s2B00tndTKCmQynCZ/swMnlVonsl8E8APc76Wd3RvR+mQ3lCuKcJsdciTLH09RRibNMQ6HjorsxzSeHhTCMlxSdna7MzOMvfDsXSuKfY4WT0p9ZTWvtAVnaY825jRt2I/xU0dKvNzbdJgnp8STzDvLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Mf9Lf34EpXyvHcwQAojThIoYlsMWZcFWEFLZfYOlwk=;
 b=FYathTz1s10Jf6PxLskWO+aaZWQDQYxXY/+5Jjoghjx338C2OFvUDVZ7ZZ+SNMXcq5XIHa/K6v8dAlNY6QFt67LO3v5jw2UAbaDRtUiGLDpKOXEzNG5tl45fhLLlOaXzRJ8BSz7hwi0EpJzis28Gb9N40vLFp9//D2RAITTeOKwkVCduFdF6dao8dugfvgoh1wuBkrVI7H2Ghjuo2cb4RKX9NgcODb7ahyLRiiVrlySzN79II2rx4SEtKV91KB4CkpAl+3NjPTNdjP0MVy0Rq4DhhWR9FghabVMZqOPYtXLA0E5RDZDj1GpHfMVeVFSupbJFhjOwgbSauxWbj+A5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Mf9Lf34EpXyvHcwQAojThIoYlsMWZcFWEFLZfYOlwk=;
 b=bt2bF4iVe7PXQb1e9H5VPWm/F4G/or7xgoVE0Urst3CdFS0FfrW8pahXYlkNB0UJJP0SJbxuh+BFbIqAWuM433J3bUX7hQllnNt7nUuazt3B8X52EAfvWSs7bt+POKPJ2xP9v38e5U4DsJZpzKNFISpUYH5hSTu8SLuteWB55fs=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by CO1PR11MB4770.namprd11.prod.outlook.com (2603:10b6:303:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 18:59:10 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::d6a3:51ad:f300:ebae]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::d6a3:51ad:f300:ebae%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 18:59:10 +0000
From:   "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Thread-Topic: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Thread-Index: AQHZmpwNhDd19o/UvkKcR6DrdZh/0a+CR0eAgAAG6YaAAAxbAIAACcwAgAAWrFCAADpvgIAAALqGgAAZJACAAAP6Tg==
Date:   Fri, 9 Jun 2023 18:59:10 +0000
Message-ID: <CH0PR11MB529969A40E91169B8CBDDB39CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
References: <20230609063118.24852-1-amiculas@cisco.com>
         <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
         <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
         <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
         <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
         <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
         <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com>
         <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <6896176b44d5e9675899403c88d82b1d1855311f.camel@HansenPartnership.com>
In-Reply-To: <6896176b44d5e9675899403c88d82b1d1855311f.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|CO1PR11MB4770:EE_
x-ms-office365-filtering-correlation-id: 05d56bb5-8010-4af1-41b6-08db691b9c19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8r3iFWEnzbGPaGwCG+R/HQrhYV26N6HmhwljfdOA9rmC89GXci3/RiwgUWIT4RJLexpoSGB02fZQnylXJJ5pG7oivQh+GHWvnx5KnXqRUdlY4hrAndEKB7/b0CEfi+WuQHw7lB7It8gQuQxjg0xTJ3kTGMYrO58aKfTdcUtIjN9292MlXjnBcKDGpMTYdYcJ+s+8zic1dcDfUHOurHo/OzlOpX/urRrPpX8KJqjpwH9vHntw186GNUxeS+xyLgDQA+d4u+3xxcuh5/hZRPDlY7HzSx88+XkPS9dqOdw+zQaGZOIP1mShU7HHHuY4WYZKJe21pQEgKEMvgZmwgLmoQPzFT+0W3FfzD/L6orQ1B+hnk01YKlypFmv77XSzAhoow0+XxOywST9U3ODnqUoTz6Kuuaq/Q+SFpekxq637EJbzYro5mgdYLD7rZA53fYF2jkiM2Y0qLFwaonazCXSWXVRfZR2aSjdN0sWCW47d0kZh/deNbX0WvJJYgDZbK1Ocl8oo7vDcgo5H9j5xqypjHfk1qSX+cQRfHJxKgyLiz74qq4XYDmLUZCycVVmK1VVqpAd2x2bgHiJeommxPU2OxCQ9QPI+Q28cXXZlu2GBnovoAjmVrs52o1S/YdeOUU84xXcM6phgGQ62FUdpSIM6Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(66946007)(66476007)(91956017)(2906002)(478600001)(54906003)(45080400002)(66446008)(4326008)(8936002)(8676002)(64756008)(316002)(41300700001)(110136005)(5660300002)(66556008)(76116006)(52536014)(71200400001)(7696005)(9686003)(6506007)(33656002)(53546011)(966005)(186003)(38100700002)(55016003)(86362001)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q0kPnvPonjt/LA3TV65c4j51eDIV6eGRti6dRVrMBpZyZKwOeP+3bIbmpfcF?=
 =?us-ascii?Q?EsGgzapgc760xzrKkZKHgLBLSKt4+U7YZJK1+Yh/GigJplsAobaUFebIEFyt?=
 =?us-ascii?Q?6EpZ61NK0ZGBSYqdiJeEu3ojmfGZMT0tc+3MPQ/Dzwp0ruzVexVkJP1KZw7W?=
 =?us-ascii?Q?AoFoE0TItcFhDPghEopM0A8fqL3mi8g1BSzj+8UjNxoUuY1RjhH8i8Esktt7?=
 =?us-ascii?Q?mlEtLo5K7Pmt6zUGBC+pxUSWxcVPNurnJ/OX7qmBSJ6pnqkDnd+SJ+sOjImS?=
 =?us-ascii?Q?akq0h9AO0BLrRW98+cRrrpVTx+JspDIO1r6FPKhxR/MQp9SbxAvyM/suhaFE?=
 =?us-ascii?Q?im+QeVsHJknRoQ7H2hSiR+tjhtdkt81d/LYiSejzzYa7TlWfeoPmYe/gul0h?=
 =?us-ascii?Q?129YRk8nYDG7M7FPEjWhZh4KGQZRiiyCj871Z8rHw1wUwDSUXhR4fG8bYEXX?=
 =?us-ascii?Q?R6BRAQsxlhgzNbEAmLIhUyt3pZNutUONMGh4+haFTDsfkWKG67Bo5ioNWps8?=
 =?us-ascii?Q?29/4qRHnZA2EKYNhGCIfKTnYXKQjjeMlkurZ0+hs5uL1eQRV21hUJvQDVjH/?=
 =?us-ascii?Q?cFugxcHYl43XUmmIIgVKe2lmEalVL5UXnBO44oy9PuWts5DYmzPrvr13uSZP?=
 =?us-ascii?Q?mAouhqo+JzHfIwkzeceOmF4vPkdbJDbJUycIH11GroUkCkGkNQu4imYesG6T?=
 =?us-ascii?Q?R4WBq2t3mijenImNzF8b9CgtCvDSRnqq5F34UhkLthnyyITxpHq5eokzavns?=
 =?us-ascii?Q?RRQVeWzKKAmAq17Uci/Xoz3ggP2DnUWK5mx0NXYJ1ZZblRT/4vI42kIsKQXp?=
 =?us-ascii?Q?wwgXOzMTrNBIHXLKPiMQ4nEJwpN1UhPutRAQLztqdFgX62azkj+Jb23hi9AY?=
 =?us-ascii?Q?OUEB5h73eiZ04bMWH1zTpafHy4mpVqv7Kk/FFkwQr00flzBgxVc/7lYIZyC1?=
 =?us-ascii?Q?myrHzwUvrdp+9/lKg3lY9tQ+rr+uwAHxNl6xx7uvgCoqU7y/N3eCSNNUCElO?=
 =?us-ascii?Q?XjgTKuL1MZwv1wi3k4kZsHA6f+bOu9DRWT0pmoLoEhAaGYYcJT59MhRf8YMZ?=
 =?us-ascii?Q?XkJDls6bpJq2zlZf0k3m7idum85np3e8SjaueUk0NKjCt0u3FMYZQDpTUh/9?=
 =?us-ascii?Q?Mq/vV/DVUT0am8hOn2MZAL7GrveIjdh6ZDP3F5bvdL0+SylH+N/aFlfwSWxO?=
 =?us-ascii?Q?j9b5XXGy5A2yuZIjvNDMu1vbioKrG/aWNaevbd1h583MA0bqobMhkiyxV5SV?=
 =?us-ascii?Q?PqBspB9ETmJvt3UAdV7sFy67x7RbJsYjZWy+paWca6gMTV2vQRi6k6x1YWPX?=
 =?us-ascii?Q?TPvnNA8OV8KU6Q+iZSvyJxJoMRng9L5DpjxHu6vWiYrplPEQt9ejuZxjsjv/?=
 =?us-ascii?Q?tEQfx4TxjX7pLKm0UBfAeMsTBoYiaRPp79dWqIDV3960goMpByr2kjqh1TMA?=
 =?us-ascii?Q?11VsZRSsCZisRCVMnkqfzOVsnd2WmUhDoCK5NoKXdjg7fBKV4uAUyTjcXQGv?=
 =?us-ascii?Q?OrFvk4TgBTzu+jb9rPL8Z3ll3VmcV4VdybbZEI7WaVigcGrxX1Q5DwwhQc+F?=
 =?us-ascii?Q?F9RdV/c3ThYadeIHHH3vbRhsW6kSxRq2tDsoVAueyZRbHv4T0t/DnSdPSR4G?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d56bb5-8010-4af1-41b6-08db691b9c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 18:59:10.6962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+Capm5GqJaddgygW3Ge80yesDRd7IvOFf0rkvs5h94igJOF2yGKEuvTammK3fcyVKohgT2joZTP78rKJUkJOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4770
X-Outbound-SMTP-Client: 173.37.147.253, alln-opgw-5.cisco.com
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

I did use git send-email for sending this patch series, but I cannot find a=
ny setting in the Outlook web client for disabling "top posting" when reply=
ing to emails:
https://answers.microsoft.com/en-us/outlook_com/forum/all/eliminate-top-pos=
ting/5e1e5729-30f8-41e9-84cb-fb5e81229c7c

Regards,
Ariel

________________________________________
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sent: Friday, June 9, 2023 9:43 PM
To: Ariel Miculas (amiculas); Trilok Soni; Colin Walters; Christian Brauner
Cc: linux-fsdevel@vger.kernel.org; rust-for-linux@vger.kernel.org; linux-mm=
@kvack.org
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver

On Fri, 2023-06-09 at 17:16 +0000, Ariel Miculas (amiculas) wrote:
> I could switch to my personal gmail, but last time Miguel Ojeda asked
> me to use my cisco email when I send commits signed off by
> amiculas@cisco.com.
> If this is not a hard requirement, then I could switch.

For sending patches, you can simply use git-send-email.  All you need
to point it at is the outgoing email server (which should be a config
setting in whatever tool you are using now).  We have a (reasonably) up
to date document with some recommendations:

https://www.kernel.org/doc/html/latest/process/email-clients.html

I've successfully used evolution with an exchange server for many
years, but the interface isn't to everyone's taste and Mozilla
Thunderbird is also known to connect to it.  Basic outlook has proven
impossible to configure correctly (which is why it doesn't have an
entry).

Regards,

James

