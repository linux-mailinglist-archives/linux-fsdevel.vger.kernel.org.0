Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7473F692E79
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Feb 2023 06:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBKFL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Feb 2023 00:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKFLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Feb 2023 00:11:24 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Feb 2023 21:11:23 PST
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446322D76;
        Fri, 10 Feb 2023 21:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4100; q=dns/txt; s=iport;
  t=1676092283; x=1677301883;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=lgBfKCHfZ4SeJg1k2U+sv76g5OeH//OjOEfYiiyLGnQ=;
  b=E/J2Lbjq2W+rIK8eoomtEj4TS8PwLLyt+izbql4uNRw70W3L+srrbdap
   ktCiekv8oWZiYv2xFvG53xN547xZ0u8yrMmbeGKWQhzwF4rounrThEaeP
   t22oZPzyRC/CNdOiRfEwyKQFnXcglbavr4KepuCVEPqvw5IQxUrras9hO
   M=;
X-IPAS-Result: =?us-ascii?q?A0AsAACUIedjmI9dJa1aHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YFaUoEHAlk6RogeA4RQX4V9giWcGIEsgSUDVg8BAQENAQE5CwQBAYFaAYMyA?=
 =?us-ascii?q?oUoAiU0CQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBBwQUAQEBAQEBAQEeG?=
 =?us-ascii?q?QUOECeFaA2GbigGAQE4EQE9AQU9JgEEARoaglwBgyIDAQ8GPqFLAYE/Aoofe?=
 =?us-ascii?q?IE0gQGCCAEBBgQEnx8DBoFAAYdAHliIdSccgUlEgViCN4FXgXkCAQEYgUgwg?=
 =?us-ascii?q?1+CLoEIAYxaJ4dygTZ3gSQOgUSBCQIJAhFzgRkIaIFhNwNEHUADC3U/NQYQJ?=
 =?us-ascii?q?AUEPAYCDx82BgMJAwIhS3clJAUDCxUqRwQINgUGTxECCA8SDyxDDkI3NBMGg?=
 =?us-ascii?q?QYLDhEDUIFJBHOBFwoCVJddgRoKLQEkgRQaCAwWAiBgTQQNXTySISiOUaFnC?=
 =?us-ascii?q?oN2ij6BIpUuFqkuAZdSII0ylQQuAYRpAgQCBAUCDgEBBoFiOoFbcBWDIh8zG?=
 =?us-ascii?q?Q9djUMJAw0JFYM7hRSKTXUCOQIHCwEBAwmMKQEB?=
IronPort-PHdr: A9a23:VC6+DRMMa2UbmtSC9xAl6ncDWUAX0o4cdiYZ6Zsi3rRJdKnrv5HvJ
 1fW6vgliljVFZ7a5PRJh6uz0ejgVGUM7IzHvCUEd5pBBBMAgN8dygonBsPNAEbnLfnsOio9G
 skKVFJs83yhd0ZPH8OrbFzJqXr05jkXSX3C
IronPort-Data: A9a23:8THwTKKKR7khSPUkFE+R0pUlxSXFcZb7ZxGr2PjKsXjdYENShDcPn
 WcXCm7VPf+JZ2Lyf4hxa9+zpEoPucTTytY3HQcd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcIZsCCW0Si6FatANl1EkvU2zbue6WbGs1hxZH1c+E3970Es7wobVv6Yx6TSHK1LV0
 T/Ni5W31G+Ng1aY5UpNtspvADs21BjDkGtwUm4WPJinj3eC/5UhN6/zEInqR5fOria4KcbhL
 wrL5OnREmo0ZH7BAPv9+lrwWhVirrI/oWFih1IOM5VOjCSuqQQV4IM0PvQMa30PyA2jtsBb4
 9dVtpavHFJB0q3kwIzxUjFCGC14eKZB4rKCfj60sNeYyAvNdH6EL/dGVR5te9ZHvLcsRzgSr
 pT0KxhVBvyHr+u8wLO3Q8Fnh98oK4/gO4Z3VnRIl26AU6x4GcGrr6Pi2dRB0mg1pJlyHdHCQ
 uYnNXlPTkuYfEgaUrsQIMtuwLj37pXlSBVcqVSIte807nLVwQhZzrfgKpzWd8aMSMETmVyXz
 krC/mLkElQUL9CS1zeB2myji/WJni7hXo8WUrqi+ZZXbEa73GcfDlgdUkG25Kb/gU+lUNUZI
 EsRksYzkUQs3GuZa9b3UQ26mibHhjQ1S/B7EfU54h7Yn8I4/D2lLmQDSzdAbvkvu8k3WSEm2
 ze1czXBWGAHXFq9FC71y1uEkd+hEXNKcjJaNEfoWSNAsoaz+thi5v7aZo87SPbdszHjJd3nL
 9m3QMUWnb4fi4sA0L+2uA+BiDO3rZ+PRQkwjuk2Yo5Hxl0hDGJGT9X4gbQ+0RqmBNzJJrVml
 CNd8/VyFMhUUfmweNWlGY3h5o2B6fefKyH7ilVyBZQn/DnF0yf9It4IvWoufxs2Y5lsldrVj
 Kn75F45CHh7YSXCUEOLS9nZ5zkClPK5To21Cpg4kPIePckZmPC7ENFGPB7MgD+FfLkEmqAkM
 pDTate3EXsfEsxaIMmeGY8gPUsQ7nlmnwv7HMmjpzz+iOb2TCDOE98tbgDRBt3VGYvZ+m05B
 f4FaZvTo/ieOcWjChTqHXk7dAFQfCdhW8mrwyGVH8baSjdb9KgaI6e56dscl0ZNxsy5Ss+gE
 qmBZ3Jl
IronPort-HdrOrdr: A9a23:1RMVk6wT7nuSKl6e93CiKrPxreskLtp133Aq2lEZdPULSKKlfp
 GV88jziyWZtN9IYgBapTnyAtj7fZq6z+8/3WBxB8brYOCCggqVxe5ZnPLfKlHbak/DH41mpO
 1dmspFeaXN5DFB5K6QimTZYrUdKbK8gcSVbJLlvhFQpHZRGsZdBmlCe2OmO3wzYDMDKYsyFZ
 Ka6MYCjSGnY24rYsOyAWRAd/TfpvXQ/aiWLCIuNloC0k2jnDmo4Ln1H1yzxREFSQ5Cxr8k7C
 zsjxH53KO+qPu2oyWsm1M7rq4m1+cJ+OEzRfBkufJlagkETTzYJ7iJbofy8gzdZtvfqmrC3u
 O85ivIdP4Dlk85NlvF3ScFnTOQlArHLxTZuBmlabyJm72/eNtyMbs/uatJNhTe8EYup9d6ze
 ZC2H+YrYNeCVfakD36/MWgbWAcqqOYmwtWrQcotQ0qbaIOLLtK6YAP9kJcF5kNWCr89YA8Ce
 FrSMXR/uxff1+WZ23Q+jAH+q3kYl0jWhOdBkQSsM2c1DZb2Hh/0ksD3cQa2nMN7og0RZVI7/
 nNdq5oiLZNRMkLar8VPpZ2feKnTmjWBR7cOmObJlrqUKkBJnLWspbypK444em7EaZ4vqfaWK
 6xI2+wmVRCC34GU/f+oqGj2iq9MVmAYQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,289,1669075200"; 
   d="scan'208";a="27162609"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 11 Feb 2023 05:10:20 +0000
Received: from mail.cisco.com (xfe-rcd-003.cisco.com [173.37.227.251])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 31B5AIV1001429
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 11 Feb 2023 05:10:18 GMT
Received: from xfe-rcd-005.cisco.com (173.37.227.253) by xfe-rcd-003.cisco.com
 (173.37.227.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 10 Feb
 2023 23:10:17 -0600
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-005.cisco.com (173.37.227.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9
 via Frontend Transport; Fri, 10 Feb 2023 23:10:17 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGfAlIJr61k5QDjShb78XwWusPgDlRBxmZHbmJcmnZy8gjBD+WEE/kDi2e2XODvuq60RH1AyDXzX+UUZMI0Ne0CfELmRq1mK7FCqdQ9Xsy3fbrmEtFW7b339PhWno//cZ7ON53bXhPNMYymhUjH29QaOfF9NcgVgjti21BBhEB0sM4dzgBc81rOcLOv36n/CIbxfyaeq8U43TmH1lm6b6fH3Fostg9xWNCHqUFdOseizvNP4WpHINCvOnnEqpbw1OOyzZD4cHdD4DxPRbjls7IIaM2ABPMQtseaYtifqHGcBOCCUo+UsQyB4JnAQW2s5FYpBkyzC8SJEyYcI2uV+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g342ofpIw5LThkKEUHP34JRY1CeQnV7LeBUgNdv73Z0=;
 b=eOQsVCacvPEdjItmuh4SM6jZFMT1xpRm2r9HDr8Byjdm12XLkzFSkXBBZQvrjQI7ycvo+/AJ2Kt6NEFwAyDX2+jgbZAyYBxpSyRxBwONUJKmYhnBVJHJ551uVg/gB+NjEb/97HVaQ6kseCPwQ7GobiuPRr5/LTfpyoFokwCbprOFNGMzTMoPxselaU0N7/R9aEsqWGg0zcRJYv+WLJCRRYkYCQbRJq59xI9TC4U1iviMSB472jR5zGWmktOPzm/tt3WgsadL3xsmQW2RY1QpcMJE0N9UlLm++AgAudbhogUe5l7JC37ab5EZ/pr6yTzVpNU2dIYgJe9bwelBhgOp5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g342ofpIw5LThkKEUHP34JRY1CeQnV7LeBUgNdv73Z0=;
 b=F9ouOhJxoY+rqiG6uFhz6Ekw1mPGBKE/+DmlF9NaBb9cFqsDTXDX6neeoCzSuds3a5YlauELhfyAjpJJDPoij8zoUlAlgzjzJciBuUOKoz9LOF8wmpne9kAztIdJaO+5ud4vd5wVnr7wfzNah2DDaz5L0GdXeb1kmWIFP36Vt5k=
Received: from PH7PR11MB5957.namprd11.prod.outlook.com (2603:10b6:510:1e0::14)
 by BL1PR11MB5383.namprd11.prod.outlook.com (2603:10b6:208:318::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Sat, 11 Feb
 2023 05:10:10 +0000
Received: from PH7PR11MB5957.namprd11.prod.outlook.com
 ([fe80::7077:cf27:946e:1d14]) by PH7PR11MB5957.namprd11.prod.outlook.com
 ([fe80::7077:cf27:946e:1d14%5]) with mapi id 15.20.6086.017; Sat, 11 Feb 2023
 05:10:10 +0000
From:   "Abhi Das (abhida)" <abhida@cisco.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG REPORT] Coredump allocates and maps, unallocated sectors of
 shared memory regions, in a program, during program termination
Thread-Topic: [BUG REPORT] Coredump allocates and maps, unallocated sectors of
 shared memory regions, in a program, during program termination
Thread-Index: Adk91w+eAU83npduTcKhNRUKd0hsww==
Date:   Sat, 11 Feb 2023 05:10:09 +0000
Message-ID: <PH7PR11MB59570A36D6595A3EC2113E23C7DF9@PH7PR11MB5957.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cisco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5957:EE_|BL1PR11MB5383:EE_
x-ms-office365-filtering-correlation-id: 78df4ce9-f661-4ca2-83b7-08db0bee3f80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ey7Qmj/lsRPpsSUUp5qRAPXQEODATqip4VPHgPY6RES227ZurfN3JLJIeXUbERKreNe8UAjfh6yzJE05Hzxbs+VlG/ylgHyD9UWi0UUcDL/wUFouet6iA+E0HKIi+IiWGHIDJ+ApGWoMU4keA2dF4dhfKCR+hd3zxMJ3MIbT2AijMEG8eRYhKqbNnmB+eyhllzwdNUB+CJBbuQZIgKgISUN55JiUTvrvuLmXSkBJzWO5eP8KKm1sziiSc2/Rqau1DvrTr1bOWLGhT0l8I8HAxnTJ61zrHJlQHsfOUCVDZME8Adnahl4GfzdCHdLW3r3d1s5qfZuHNB4sfo30Oc5zXZ+kKp6zY5a56VRbZAbvbV8r0mB/a/VxuQf4FqLbFFfo6X1hkG9ta/oO2No/kRUtK8nL3Q+6OLlPcl/KP00l0eG8q+gLljfj4Qhgj4ozyj8YpesFqOxsPl7bTmvtmZ6Uu4lZP1OVe5k2ls240VPgU7COQ6RL+RAyZXSUOZXUFsehUR+6QOO3HsOMGZKYV9cRuVqLi0be3CoRdcKLXFx7OGpGXxq3eb6AgLwaDsaPXq3SPBumDKGicqPywOgkSZY+DJqZ+gN0V+ZejUd0KOgU2z+rcSn4vkh/zyXyxnCvs5LhxOwiYF7tpRbvsJrjXvLuIzZNM4/09Rgb8dMjSG+8UJVMQmpsQTxtmtNzk4chxEKRvKt5Ri0sVsjWzunh5hMLybOanOMB6w0SkIk8pE19YHk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5957.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199018)(38070700005)(86362001)(33656002)(64756008)(8676002)(76116006)(316002)(66446008)(66476007)(66556008)(450100002)(110136005)(66946007)(966005)(478600001)(7696005)(71200400001)(2906002)(52536014)(8936002)(41300700001)(5660300002)(83380400001)(122000001)(38100700002)(55016003)(186003)(26005)(9686003)(6506007)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xnd1V0CIojzpFn3H5Dl4uJnKxATOoDZewfbPuhJnJHx2nGjLVyKo10YhqI2T?=
 =?us-ascii?Q?Sa8Z67p0wN9Omu3mhDvBTB9rQYx2inEL2Ozm7xdE+PrN3XowG7rdzznZtNwQ?=
 =?us-ascii?Q?dy0KW9nP5GqgCQtWuY7VAcTg5kl1mYethapHJkjoeYuQK+PUAn8wXTmrMDOG?=
 =?us-ascii?Q?57ZBasuxHbX1GYCoEZhyGBNNIme2Xm1/gMjr3Y30g43ltW43LuB01CSL2+m9?=
 =?us-ascii?Q?YL6LVLKy5i4KiJXwL3wshqh5k7LpSVJAmEk2zKwwpUwzJjQdA8pu5imeaY+g?=
 =?us-ascii?Q?aF4IzlFwbCo3+8trYSo9LgOkyzGKEFFWOS+YLIE6Hf6yIhmAHxzE1skD+VRm?=
 =?us-ascii?Q?FS143yeX9UUGV3+rq6CEWh0fBOF8CvlsRd5fQZXDUzXf6cI6MaAT985nVVPO?=
 =?us-ascii?Q?rGkd1B2MkDixBp3BwOB/EmTBtH+aWLe3stx6QG2hSGMlx32juDxhg5IySEmg?=
 =?us-ascii?Q?5JqGD3w/w7BYsavV6vz+ZtNd6hozs1VK2ABLMKovr6P54n7cTEVkwiL1DilF?=
 =?us-ascii?Q?J6GIGIN6EugIYPZWNcBDIqctkYOO0MRKa4rZ6pYfOI6bO3WHQ37PUnFwr035?=
 =?us-ascii?Q?k4z6Gz6tdQ7FWsJ8aGD3aHEOscjRo5Hd8oQLbp7P8cXgW3KFyRVE7z+a/mdm?=
 =?us-ascii?Q?dBVLMchMiMLJQxQwjhidOqhTyiRNPxkfVlcKmAu2jq/ZBhVLVdroran5gQrj?=
 =?us-ascii?Q?SYqHpaBKqediCTB/lY+nj/xDzpHcdOaAxIJ0aA5fXzu0NHmAGxQoM82fQdlj?=
 =?us-ascii?Q?6NuVT8B3IMENjR5mx1z9l7UUAKfxH0QOX+EUUY385Jo9ZvQpp3KFRx4rCGnG?=
 =?us-ascii?Q?VoBvoA8geVhkDa0ZsVUY8OYkLc3FOUN/PSeHVm86h2he2GbBWwucGCuGZfWe?=
 =?us-ascii?Q?h33Dzx71MdCqMFbDo3qM0dRzDrlpSBJccZWVlRU9OA74imKiMUeSORd4bpOV?=
 =?us-ascii?Q?A1+HuWe3fSU+/LKrXOlKmBQ+HaQI+itvW5Lj7ygRsbW2r5huZS76DsWUUaAk?=
 =?us-ascii?Q?+JAanJew/KgKgTEjXVMZmv/SDpJCEsR0SRWU1aZwLI0Xxm78wtbbWmc9f5eG?=
 =?us-ascii?Q?ZWc9K0NRhCMBMGTUyytmVy09uSNdnz2EVrRJdxc4TRCYgJA8jWsNnicK5lgn?=
 =?us-ascii?Q?hCkzOKusrpuSpQRgKt+ya9ySblCw4z/y5cnxtVAbV47mFAgelHYwxSblXOjE?=
 =?us-ascii?Q?8E2oJc0hN6htkO3divnWQ78rxv7VnHxhxeTI92eI9NZl1647xt9rz6k0KPky?=
 =?us-ascii?Q?HjeJOwqNl6NEa8XO1ChE8SsxBvR/i0z6YUyTRXjKATYeeSD9vopgBKw4URZB?=
 =?us-ascii?Q?FTcQkJrf7zaRn8c4f22PPSHpR6K7/XyHiXyQ2aEijm1a+NYLjb+GUI0UKbFK?=
 =?us-ascii?Q?dp8RwWBI+SbjLFrfeqLJgv6C00s/TLAU9hl3EeZyAeVoanvzAYw/+ZCbvZPz?=
 =?us-ascii?Q?AjKhFZc22jTygtvKdZ/tL7fu63wbnZCvhJs7FZRwWwNlh02EsGEmF/lrQlHu?=
 =?us-ascii?Q?mVZ/31zzKCRlLjuRSwqXU6SWs848K3BtXFgXhpX1FACE7RAIFEpCRSRaE67W?=
 =?us-ascii?Q?VrN+x1FKplj8kGondH8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5957.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78df4ce9-f661-4ca2-83b7-08db0bee3f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 05:10:09.8253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2MWIiO0O1NGlNXVGEdLvnms/ts018MLBP1j3A/5xET9rKHblhvVrWIHiBvLwJCzRGuCiO5YNXrZ1xl4Ndg5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5383
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.227.251, xfe-rcd-003.cisco.com
X-Outbound-Node: rcdn-core-7.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I have noticed a flaw in the linux kernel's coredump system. I have observe=
d that unallocated sectors of shared memory regions in any program's virtua=
l address space, get forcefully allocated and mapped when said programs ter=
minate and produce coredumps.

I created a simple 1G shared memory mapping, and wrote only 4kb of data to =
the region. I expected only one, 4k sized page, to be allocated and mapped.=
 On program termination with coredumps enabled, I expected the program's bi=
nary core file, produced by coredump, to just contain 4kb of data for the s=
hared memory region in question.=20
I also expected the corresponding file for the shared memory region, in /de=
v/shm, to be backed up by a single 4k sized block on the file system.=20

However, I have observed that the terminated process' binary core file cont=
ained 1Gb of data for the shared memory region. While the file for the shar=
ed memory region, within /dev/shm, was now backed up by several blocks on t=
he filesystem adding up to 1GB of data. This indicates that coredump forcef=
ully allocated and mapped the remainder of the unused pages in the 1GB shar=
ed memory region.

I have replicated this issue on a ubuntu vm, with 8G of ram and vanilla lin=
ux kernels 6.1, 6.0, 5.18, 5.15.64, 5.4.212. All vanilla kernels were compi=
led and installed manually. The system was also never tainted. All thought =
other kernel versions were not tested, I am quite confident that the issue =
exists in other kernel versions.

I have also filed the details of this issue in bugzilla, and I have detaile=
d the steps that can be taken to reproduce the issue, here you can find the=
 code I used to reproduce the bug: https://bugzilla.kernel.org/show_bug.cgi=
?id=3D217010
I have also attached a screenshot of shell commands from a system with kern=
el 6.1, that clearly reproduce the issue: https://bugzilla.kernel.org/attac=
hment.cgi?id=3D303704&action=3Dedit.

To reproduce the issue, set core_pattern to "core" by running 'echo core > =
/proc/sys/kernel/core_pattern' and set the coredump filter mask to 0x000000=
7B, with 'echo 0x0000007B > /proc/self/coredump_filter'.
This will ensure a programs core file will be kept in the same directory as=
 the program, for simplicity. While the filter mask will ensure that coredu=
mp collects all types of memory mappings from the virtual address space. Th=
is information is referenced from https://man7.org/linux/man-pages/man5/cor=
e.5.html

The commands in the screenshot are explained as follow:
- a system contains 6.9G of available memory.
- begin execution of program called fractional_memeater.bin, with following=
 input parameters
    - size of shared memory sector in bytes
    - fraction of shared memory sector to be written to, i.e 1/10th in this=
 example.
    - name of shared memory sector
- program is stalled after it successfully creates the memory mapping and w=
rites to a fraction of the total sector (it is now waiting to be terminated=
).
- the system now has 6.8G available memory, while displaying 100MB of share=
d memory is being used.
- the df utility is used to show that 100Mb, is the approximate amount of u=
sed memory in the /dev/shm directory.=20
- 'stat /dev/shm/shm_1G_100Mb' is used to show that the shared memory file =
is currently being backed up by 100MB of data on the filesystem.
- program is terminated with kill -6
- free utility displays that the amount of available memory on the device i=
s now 5.9G, it has dropped by 1Gb. While the amount of shared memory is now=
 1G.
- df shows that /dev/shm is now using 1G on the file system.
- stat utility on shared object file, shows that the file is being backed b=
y 1G on the filesystem.

Note: This system is a vm of ubuntu running a vanilla 6.1 kernel, with no o=
ther shared memory objects on the system, expect the one discussed. The sys=
tem has also not been tainted.

Could this be expected behavior for fs/coredump.c? If not, how can we work =
towards a potential upstream fix?

Thanks.
