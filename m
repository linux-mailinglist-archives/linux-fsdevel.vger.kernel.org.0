Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1407298F0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbjFIMDL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjFIMDJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:03:09 -0400
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322B1A2;
        Fri,  9 Jun 2023 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2667; q=dns/txt; s=iport;
  t=1686312187; x=1687521787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6/7aVulLipu8UgQgO2ZJ/0gZ5PLTq9dgV90cIbuYu04=;
  b=dp1eWP4hW6xNWw1AC5h1x8kqTx5vBJm5OV2ex+QipCovm+uvKGJVNpLS
   EWpet1gXjK4Ns/m0oHZJPf8XfXEtPCqta98GdbfQa22Wx37kI6JI1HcqJ
   pZoh/45w6IkT+vwr5Jt4CiVVDlDjYuPkuqcn5aF4uO+XO9UYiKZ6s1B81
   8=;
X-IPAS-Result: =?us-ascii?q?A0AwAAD8E4NkmIENJK1aHAEBAQEBAQcBARIBAQQEAQFAJ?=
 =?us-ascii?q?YEXBgEBCwGBXFJzWyoSR4gdA4UtiFIDnWuBJQNWDwEBAQ0BAUQEAQGBU4MzA?=
 =?us-ascii?q?oV0AiU1CA4BAgICAQEBAQMCAwEBAQEBAQMBAQUBAQECAQcEFAEBAQEBAQEBH?=
 =?us-ascii?q?hkFEA4nhWgNhgQBAQEBAgESLgEBLAYFAQQLAgEIEQQBAQEuMh0IAgQOBQgag?=
 =?us-ascii?q?lyCOiMDAaFFAYE/AookeIE0gQGCCAEBBgQFgVEPnUYJgUIBh1l8iQonG4FJR?=
 =?us-ascii?q?IFYgmg+gmICgWAChBKCDCKOM48ogSlvgR6BIn8CCQIRZ4EKCFyBc0ACDVQLC?=
 =?us-ascii?q?2OBHYJVAgIRKRMUUnsdAwcEAoEFEC8HBDIfCQYJGBgXJwZTBy0kCRMVQgSDW?=
 =?us-ascii?q?QqBEEAVDhGCXCoCBzY4NwNEHUADC209NRQfBQRqgVcwQIEMAiIkomIwgRomP?=
 =?us-ascii?q?xEdAUSSFZBnoQsKhAihNhepVZgWonCFHAIEAgQFAg4BAQaBZQM1gVtwFTuCZ?=
 =?us-ascii?q?1IZD44gGYNbj3l1OwIHCwEBAwmLRgEB?=
IronPort-PHdr: A9a23:mdjvexCRE0dwa/AgeOuBUyQVoBdPi9zP1kY9454jjfdJaqu8us6kN
 03E7vIrh1jMDs3X6PNB3vLfqLuoGXcB7pCIrG0YfdRSWgUEh8Qbk01oAMOMBUDhav+/Ryc7B
 89FElRi+iLzKlBbTf73fEaauXiu9XgXExT7OxByI7H8H4/ZksC+zMi5+obYZENDgz/uKb93J
 Q+9+B3YrdJewZM3M7s40BLPvnpOdqxaxHg9I1WVkle06pK7/YVo9GJbvPdJyg==
IronPort-Data: A9a23:C3frX6Iu1CQ7aBHLFE+R+pUlxSXFcZb7ZxGr2PjKsXjdYENS0jxUy
 DFLWWzVbvuPambxKot+Pouw9U4E7JKAzodkGgQd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcIZsCCW0Si6FatANl1EkvU2zbuS6ULas1hxZH1c+E39/0UM7wobVv6Yx6TSHK1LV0
 T/Ni5W31G+Ng1aY5UpNtspvADs21BjDkGtwUm4WPJinj3eC/5UhN6/zEInqR5fOria4KcbhL
 wrL5OnREmo0ZH7BAPv9+lrwWhVirrI/oWFih1IOM5VOjCSuqQQV+5Q8LLkfTXsNigTYkP9Lz
 PZ3hbmvHFJB0q3kwIzxUjFRFyV4eKZB4rKCcD60sNeYyAvNdH6EL/dGVR5te9ZGvL8sRzgUp
 JT0KxhVBvyHr+uzwbmmTuB3rs8iN8LseogYvxmMyBmAVKh4GsudEv+iCdlwzRM3odpgAtLkO
 pAXTyFvNkn4YR5VNQJCYH45tL742iagG9FCk3qPuLErpmbU1kl10b7wIPLLddGQA8ZYhECVo
 iTB5WuRKhUbMsGPjDSe/n+yi+vngyz2QsQRGae++/osh0ecrlH/EzUfUV+95PK+kEP7CpRUK
 lcf/Wwlqq1aGFGXosfVeDSKp2bHvTogAdthQuIV0gWu8Jrx/FPMboQbdQJpZNsjvc4wYDUl0
 F6Vgt/kbQCDVpXIGRpxEZ/J8VuP1TgpwXwqPnVUEFdZizX3iMRi0E+eH44L/Lud04WdJN3m/
 9ydQMHSbZ08hNQP3qO3lbwsq23x/sSSJuLZC/m+Y45Ixgp9YIjgbIuy5B2Kq/1BN42eCFKGu
 RDoevRyDshQVPlhdwTUH43h+Y1FAd7ZbVUwZnY0T/EcG8yFoSLLQGypyGgWyL1VGsgFYyT1R
 0TYpBlc4pReVFPzM/8pOd7gU596kPm6fTgAahwyRoQVCnSWXFLXlByCmWbLt4wQuBF2yPpma
 cvznTiEVC9KUsyLMwZat89EgeN0mUjSNEvYRIvwyFy8wKGCaXuOIYrpw3PQBt3VGJis+V2Pm
 /4GbpPi40wGAIXWPHKNmaZNdg9iEJTOLc2swyChXrTdclMO9aBII6K5/I7NjKQ/z/kNz7aQr
 yHlMqKaoXKm7UD6xcyxQikLQJvkXI10qjQwOilEALpi8yJLjVqHhEvHS6YKQA==
IronPort-HdrOrdr: A9a23:q8cv16qdK3UmU8bGD08IczYaV5uEL9V00zEX/kB9WHVpm5Oj9v
 xGzc506farslkssSkb6K+90cm7K0819fZOkO4s1MSZLXfbUQyTXc5fBOrZsnHd8kjFltK1up
 0QCJSWZOeAaGSSyPyKnDVQcOxQjuVvkprY/9s2pk0FJWoHGsIQjTuRSDzrb3GeLzM2Y6bRYa
 Dsnvav0ADQAEj/AP7LYkXtWdKvm/T70LbdJTIWDR8u7weDyRmy7qThLhSe1hACFxtS3LYL6w
 H+4kzEz5Tml8v+5g7X1mfV4ZgTssDm0MF/CMuFjdVQAinwizyveJ9qV9S5zXMISaCUmRQXee
 v30lMd1vdImjTsl6aO0F3QMjzboXMTArnZuAalaDXY0JTErXkBert8bMpiA2vkAgwbzZBBOG
 Yh5RPCi3KRZimwxxgU67XzJmJXv1vxrnw4neEJiXtDFYMYdb9KtIQauFhYCZEaAUvBmcsa+c
 RVfYjhDcxtABunRmGcunMqzM2nX3w1EBvDSk8eutaN2zwTmHxi1UMXyMEWg39FrfsGOtR5zv
 WBNr4tmKBFT8cQY644DOAdQdGvAmiIRR7XKmqdLVnuCalCMXPQrJz85qkz+YiRCdY15Yp3nI
 6EXEJTtGY0dU6rAcqS3IdT+hSIW2m5VSSF8LAp23G4gMyKeFPGC1z2dLl1qbrTnxw2OLyvZ8
 qO
X-Talos-CUID: 9a23:3Vu0fGwpoZGtS14YVKG5BgUzM/Iiaj7e6EuKIn7pBklTTJ6veXqPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A4bNSLA6QTCOaW7K4eXhHdWH5xox5x6OJEm4Sta9?=
 =?us-ascii?q?b4ceiLiwqZg+fjy64F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 09 Jun 2023 12:03:06 +0000
Received: from alln-opgw-2.cisco.com (alln-opgw-2.cisco.com [173.37.147.250])
        by alln-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 359C35kM010593
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 12:03:06 GMT
Authentication-Results: alln-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.00,229,1681171200"; 
   d="scan'208";a="2804770"
Received: from mail-bn1nam02lp2044.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.44])
  by alln-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 12:03:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcWixkdYaElHEtT5kilw4FWN4JQngJI2JLfG7kYD6+FSRbH+149bY5aNBBEyg2s3pNCkzumszqwRaGCLK4swVQb3b10XytqsfG6oNcitJzmbqgJw3dEUbX5j6Z9q62+/w46UEDWwTaFdGYQ33333sFFJWNiJMaYxeCYUp8MxJE+59HGeGomptaL0xDEYFTkOjrFNM1BZENYHnsZpEk5HlP9z/VgsdGHQSZa78NxIHvnUb1EjfC65ScjPzkJwb0mGPqToSt+5slX9C7x20cQLykAeKxlCM5811Cd6KxMzA/EOrK8p+t/5dfJNaZo72WNTTtsWNf9AmFySDcSbNdcsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/7aVulLipu8UgQgO2ZJ/0gZ5PLTq9dgV90cIbuYu04=;
 b=lrWNEzgILWNbTlSScc2VpK2qaBaw6+Z3jOYP5bAuWNzyeBdrwfOa7rGGqQKJtyL0Lh0NrUY/+9XSferNPnRShScUWU9eXYCqvPNqZTPH2mE8lsWOXcsHDhyijIHULLRosMseLDpU91HXp6MG3GeIIrdFqSDy29oaS5GTuQrdcsH8ePhVKZaY2IevPDadsh9UpCY5ZGtGySNZsmq0cA67aqyWOTW68LAsNqiVehQpxiD/pgGSB1eHCFKWhp/z3OWpdI0QhNTvOTb/vY+yq0uvBx4Rrnfsh7rPQ2f2twqPEPn5LfLJdINaK3b6irgV3DVc1sTYB/B/cqjb4wxsYxQR2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/7aVulLipu8UgQgO2ZJ/0gZ5PLTq9dgV90cIbuYu04=;
 b=U3GQzPqtamdmzE0HD2MDKSyNAvr++03s+pVeX/fJxDdRVhqmkbTi9IaNP6YEqNGog/bfN2t7qZginDcCBC4pT/L3Q8rRoF23HYXdZi3ZbnG/UdYKXnQdWtmLkT8yCuCNn6/yATjV3vRHT9l4i+nRlFZfTOWtlBygB++9Gx4Re88=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 12:03:05 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::d6a3:51ad:f300:ebae]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::d6a3:51ad:f300:ebae%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 12:03:05 +0000
From:   "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Serge Hallyn (shallyn)" <shallyn@cisco.com>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Thread-Topic: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Thread-Index: AQHZmpwNhDd19o/UvkKcR6DrdZh/0a+CR0eAgAAG6YaAAAxbAIAABIgS
Date:   Fri, 9 Jun 2023 12:03:05 +0000
Message-ID: <CH0PR11MB52997EFC3ECB27D338962536CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
In-Reply-To: <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|BL3PR11MB6529:EE_
x-ms-office365-filtering-correlation-id: 12aa4bdf-8ec2-40d7-c115-08db68e17b9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBOmRk+gpcvTkqrRRRCDWHhQAlqVY2MUQv3lDJxITTYP45rz9EYWwrgGRwFZW+y9U7U/LWHmmF85xSHur5syxJufEO9FCglEZrUXG/Mkq+/CqNsZ48kQL03n58TKCA4kqErHBmViW7PkgsM31HPEcWWbgVzBY//gLIVVhJf7bMeltCBAPxgs7IbU3uhLmZ5rIVNzYZqwKf4GQMA7XRuNiiv+WWqTBR03Z7j9kKZsD6nn1xMnk/meiF5ro2KpdAC0Bp7jgk/VJRlv3fjhKI0nD4d9kK11100LRmLmOyfHiWTPbAMEdxeL71YCm53tBs/WiDjqinBMmg6mPJRutU6B+8pv+TWP3RZslbdzy+AWEl96vRQ/g5CpyKoWYltKI651roDUW5vsMT0cm3qgzXVzVCMi9x9sTx/2awByEks3TALRqMSzjyXKKPutSTUz6JBGCTIZqR5ipELtXAhPKLAo7BjsTNlikN4JMRdJmkh8kNxPoJAdheaovzchKyh3w+cxOGnuejqrHiLfsNpm9wXKzacd8SK9nHN+pKHuaMx5pmtfzkPfaQei+Sy3hnMlctMYieWwd3bbj7ZNleIz8/M942xCSLlz4vtgzrcfdauQPYAZd/R5XwYrrBGqb1yS+dPh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(2906002)(52536014)(41300700001)(8936002)(8676002)(5660300002)(316002)(66556008)(66446008)(64756008)(6916009)(76116006)(91956017)(66946007)(4326008)(54906003)(478600001)(66476007)(71200400001)(6506007)(7696005)(107886003)(186003)(53546011)(33656002)(86362001)(55016003)(38070700005)(9686003)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kK3BVDDr9sdyCIflXoKbTa7lPZ0P4Y1bgg5bdVD5K/NSl6yHy3g7OWaIZv?=
 =?iso-8859-1?Q?10xmGxjJZLuceNes/uTwg+2pZ/7BUK4Mi5YPxeEAQZgu8RTLk4qDUUqeKJ?=
 =?iso-8859-1?Q?qMH9ieUwy2kIAhr9F776BinfVQiflC5EZ9s755s37+BjKaZ8J5tGzPybbb?=
 =?iso-8859-1?Q?0KG7JLIPpGwvcyZG1QgQhr8qeHvtVpxOh+RTMzADrJR4Gm7lZOi+hYMr8N?=
 =?iso-8859-1?Q?7VDOetueDuO0WTxKGuMgiE81qC95jbOp2TJ+hrA1voe2yMJg72Ap3L1UJb?=
 =?iso-8859-1?Q?juUyzkh1tV/6Tc863F82CtFZhBUjNFdnuJH0PIeWvMvWkpDZ5EGLtcnSFc?=
 =?iso-8859-1?Q?ASxiM7ZjpNmpYPje7D+85mitDS1YcYihbViz7MCbM6FEOLqnq388nyBc7W?=
 =?iso-8859-1?Q?zaeuBa0So5vwW47pnUYPoUDWgHtm7eozck4eJA82XEAPsZRR/QrZtfK+yr?=
 =?iso-8859-1?Q?fJYxkNcjYhyi2gPi1/Rc6q1fzxybbggmOU7go0qLihMFhU4ImgvkR5x2cu?=
 =?iso-8859-1?Q?74HfMVWoo0Zcgz+/q9lx8KZnh9PVB7LSowH1FzQpcNX/aJjGEfr68vWfQw?=
 =?iso-8859-1?Q?VdPf6sBpoebOMLBw/TF8qnLQqypaAJ/5phzUEGMc3atHiLa78VPynmXyUH?=
 =?iso-8859-1?Q?fworlY0SEqNjSlpcQUXqEDOPgBJOrS45eSeXYhqNllWR9SEySGY/AGcr8U?=
 =?iso-8859-1?Q?u5J5B8UvW1GiuzHHLy8FyafgyQ3w+fD0xL5XAK0xsgpL7+gnw+PUhTOz2s?=
 =?iso-8859-1?Q?7j9a7gSfydONwqsuTKnjbMTjHCI1Il6DBV4uouTNmq2OwPp8LmB7sahWa9?=
 =?iso-8859-1?Q?JShe3fGJwQ6e+rd174uULLjEcxkNS1cl2zqbf87jvBMi8gYwCupR8LI8iM?=
 =?iso-8859-1?Q?mLNV5ew6w9r0G+s6iVqB+kkYacra4uCRYrsxsxjMA26bLVlWVbxiqYlcVL?=
 =?iso-8859-1?Q?T3geWUGMsEuarsoYD2to1LTrcM05gR3SWe36WfKDQWWLgvqHBVcQEK+Df+?=
 =?iso-8859-1?Q?L4kolSMXgp+WOBuNSIePGgUWjwDAwMkm7V1mo3/5kmqpkUkixLahY5k+K6?=
 =?iso-8859-1?Q?ZhIsMGAwk9jmXTI8AVpc+864k7Qxs+hewLMb+07QCA67ZRLPyV1qxxhS4T?=
 =?iso-8859-1?Q?fhwP6UEBIq+ghPzYaWcN/+q1lQUVbvd3wdFpyfTy5YVqhoIez2JsAmumKc?=
 =?iso-8859-1?Q?KvMOImF5+bsqjRogM91wtAp/sCKKsKoYbLaRPtA7u+WpyhKMwvISehkc0Q?=
 =?iso-8859-1?Q?+XcDhAOF1dfWsHMLffmvrhvw1iD1RXtAZIxyn/KoXc7rGppRF5ieZJKxTa?=
 =?iso-8859-1?Q?BEcHpBeBaGjkVj+qC3qn8I7xyyL5HYkonY7+Q55UKqaBWo7VGEvQUJzVVs?=
 =?iso-8859-1?Q?eAOyCkUo6wpujkev28OdKwqNpT23tmDd2wrm0qVWfyMiOT2QBqXCH91mlQ?=
 =?iso-8859-1?Q?5F9XZFbcN7nMYSWPotgFDaR3b6uL95+0+I4ety3EAvm8qG+zn/0VnI2fNQ?=
 =?iso-8859-1?Q?0g4ubEz86ijiuq9U7khj+cxw3Xo0H4PWw7Wk9gONfsM6m1l0IOmMcjUOkd?=
 =?iso-8859-1?Q?vB2PXtppmxaW2Hj+UNdR0YdgzKdBj4aJGhuPdq231OWGUovBXic6g2sxwl?=
 =?iso-8859-1?Q?/jJlEDQrZvqqAV31GaxXzsy6NVnD/7pvzvSrwt8cDQWmraZIf7ZdP6WQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12aa4bdf-8ec2-40d7-c115-08db68e17b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 12:03:05.3299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgUloWq7sGGKukTXg1IHogp9w1wUS+CmEQRHlDX9WbdNyYf92x8C0HJDU5yivyZcoeTMTJRTpiZqa8WU5VLXAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-Outbound-SMTP-Client: 173.37.147.250, alln-opgw-2.cisco.com
X-Outbound-Node: alln-core-9.cisco.com
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

Adding Serge Hallyn for visibility.=0A=
=0A=
Regards,=0A=
Ariel=0A=
=0A=
From: Christian Brauner <brauner@kernel.org>=0A=
Sent: Friday, June 9, 2023 2:45 PM=0A=
To: Ariel Miculas (amiculas) <amiculas@cisco.com>=0A=
Cc: linux-fsdevel@vger.kernel.org <linux-fsdevel@vger.kernel.org>; rust-for=
-linux@vger.kernel.org <rust-for-linux@vger.kernel.org>; linux-mm@kvack.org=
 <linux-mm@kvack.org>=0A=
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver =0A=
=A0=0A=
On Fri, Jun 09, 2023 at 11:22:12AM +0000, Ariel Miculas (amiculas) wrote:=
=0A=
> Hello Christian,=0A=
> =0A=
> I didn't send these patches to a wider audience because this is an=0A=
> initial prototype of the PuzzleFS driver, and it has a few=0A=
> prerequisites before it could be even considered for merging. First of=0A=
> all, the rust filesystem abstractions and their dependencies need to=0A=
> be upstreamed, then there needs to be a discussion regarding the=0A=
=0A=
Yes.=0A=
=0A=
> inclusion of third-party crates in the linux kernel.=0A=
=0A=
> =0A=
> My plan was to send these patches to the rust-for-linux mailing list and =
then start a discussion with Miguel Ojeda regarding the upstreaming approac=
h.=0A=
> There are a lot of new files added in this patch series because I've incl=
uded all the dependencies required so that my patches could be applied to t=
he rust-next branch, but these dependencies will most likely need to be ups=
treamed separately.=0A=
> =0A=
> It was never my intention to avoid your reviews, should I also send=0A=
> subsequent patches to linux-fsdevel, even if they're in the early=0A=
> stages of development?=0A=
=0A=
Yeah, I think that would be great.=0A=
=0A=
Because the series you sent here touches on a lot of things in terms of=0A=
infrastructure alone. That work could very well be rather interesting=0A=
independent of PuzzleFS. We might just want to get enough infrastructure=0A=
to start porting a tiny existing fs (binderfs or something similar=0A=
small) to Rust to see how feasible this is and to wet our appetite for=0A=
bigger changes such as accepting a new filesystem driver completely=0A=
written in Rust.=0A=
=0A=
But aside from the infrastructure discussion:=0A=
=0A=
This is yet another filesystem for solving the container image problem=0A=
in the kernel with the addition of yet another filesystem. We just went=0A=
through this excercise with another filesystem. So I'd expect some=0A=
reluctance here. Tbh, the container world keeps sending us filesystems=0A=
at an alarming rate. That's two within a few months and that leaves a=0A=
rather disorganized impression.=
