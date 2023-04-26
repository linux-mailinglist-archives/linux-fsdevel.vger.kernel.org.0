Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDFE6EF7E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbjDZPpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239858AbjDZPps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:45:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F207282;
        Wed, 26 Apr 2023 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682523947; x=1714059947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KS1916YQ6oUkZBB1o2sPjsHQJxsctuuQZbGOoLTkylQ=;
  b=g5SzrSE1sS55KNVkFsLR9fSAK2dOvjQBUTqEYuZ2GgvbQ21b0EI3x4vy
   Alhkdbnp0fV/+xqm0qA0Hhixexm6KuS5qFf4gQPewcwAU33+7yC6DZBQU
   S1Qpb2mxTYZ7jSHnPD8IS+DRk5B0kKAd81ZtcJZ9N5XXq4NsROsqd3RNK
   /oyAqOq8xxeIQDANAk3OvkJsFzTzNa5skrW+oagisC0rq/98pfqKesujD
   If1a8Jyxf3LlzXUKJkF4Eu2utMbJerLRJJNCBtx7IbQQvp1ActbWGVUw/
   dm1vsFwIMw5Gwldp/7/p1am9W6Oz6ov/xoxsP78tYUYzcLH7xT62rXNQR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="327467875"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="327467875"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 08:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="805558827"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="805558827"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 26 Apr 2023 08:45:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 08:45:46 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 08:45:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 08:45:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVd+otJ7V6BZKDAba/fusqSYxwwjUVMT+2S1zHTKw8qHKUV9KaQwGpEquqVmFYfUl8FN71y3bjkazwp9ZBJBtVb+4VMGKQtwVCsshKSZcAdNDCfzMUxH6fxr4tXiGeDUpnluy9M7WNzeZPKDjS+1yyxuMLDv4Mnq/0CG+K9uofhM4VdwvvQi0f08CFfXkYUjiMPATLCukKzeJphSj07Kl0GfamSRV9xweepiMQ1fYhhOQswRWBBurOAT1F9YuhmnOxC80eHTDV/z05RL1Ag3mmkgEmNRQawmxXg+P7yFLGm0jnUD8cUWmDEC1ZBHSKyIZlgj/ogeY2O33HBrPnqaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS1916YQ6oUkZBB1o2sPjsHQJxsctuuQZbGOoLTkylQ=;
 b=RgXpS56yBt5Plwr9pidy5rBIZbq3egiNAJ2552qNEJsTSaIh+fZiv4qsWDEPuqYOebGkVR7gn4NQDCQA5QcBy8QY7MoomAH2A8/Ci/3uIr45e7zxS5RQrMDklNeh9fkrIxaLmtxkybKwbHO9X1hiLR1l+9YzOS72fP7TYrcso7m8VXGALhvWtPxIswBNOzvDq9+FrFlwFmKVXlei+03BK893E67h6snZme6IRGyx1a/Qy+FP0OElPsUj7R9pKax9nWXBzDKk6fZmfiIgBTCd9MOqanSTyLckopxR25gYPaNFvpRz0kUfa9KLXfM4U29VkRmJysn3l3LA7dcMlagaUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB6050.namprd11.prod.outlook.com (2603:10b6:208:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 15:45:42 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 15:45:42 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "chu, jane" <jane.chu@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: RE: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Thread-Topic: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Thread-Index: AQHZdBRFPZDWlOOp3UGtHDT7fo0Pga86CEYAgACeJYCAAKEtAIABAwhQgACIswCAAOwL8A==
Date:   Wed, 26 Apr 2023 15:45:42 +0000
Message-ID: <SJ1PR11MB60833517FCAA19AC5F20FC3CFC659@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230417045323.11054-1-wangkefeng.wang@huawei.com>
 <20230418031243.GA2845864@hori.linux.bs1.fc.nec.co.jp>
 <54d761bb-1bcc-21a2-6b53-9d797a3c076b@huawei.com>
 <20230419072557.GA2926483@hori.linux.bs1.fc.nec.co.jp>
 <9fa67780-c48f-4675-731b-4e9a25cd29a0@huawei.com>
 <7d0c38a9-ed2a-a221-0c67-4a2f3945d48b@oracle.com>
 <6dc1b117-020e-be9e-7e5e-a349ffb7d00a@huawei.com>
 <9a9876a2-a2fd-40d9-b215-3e6c8207e711@huawei.com>
 <20230421031356.GA3048466@hori.linux.bs1.fc.nec.co.jp>
 <1bd6a635-5a3d-c294-38ce-5c6fcff6494f@huawei.com>
 <20230424064427.GA3267052@hori.linux.bs1.fc.nec.co.jp>
 <SJ1PR11MB60833E08F3C3028F7463FE19FC679@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <316b5a9e-5d5f-3bcf-57c1-86fafe6681c3@huawei.com>
 <SJ1PR11MB6083452F5EB3F1812C0D2DFEFC649@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6b350187-a9a5-fb37-79b1-bf69068f0182@huawei.com>
In-Reply-To: <6b350187-a9a5-fb37-79b1-bf69068f0182@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB6050:EE_
x-ms-office365-filtering-correlation-id: bff9499c-a427-422d-4e64-08db466d4b12
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9NxSwOFOMA0xQWWaaRqlhW2qOKZlfeo7Zu24bpN5ML16+F4w3wJ9oPqZ5z+6114czpDhz1Wr4h32QaqZ0vuTEzSF6uxn1T6WW5C7svGKhCGar7rBoXNE4YXgkPVDfhf8q9vw/P/nwI/K7hMsD5Yc59oWP6k3mCQRlqhsBS8E/1B8hHvHjwc+i8QxAjGdEWMgdlMGNEKtreL49Bxy1jcAX1JUKxkgsK8n7yPpA2snDg8zfxHWa5WtNN2tUtNYYs3LFPiAZHPeOVUSR+7bKFOZrZdpsaNVe8lwcPuZ71eQeJid9RUEjGK3g4KWGEZ4wFODlfuxtyz/5i/C8UfLB8cWfpWvB6CMNbnTk/9fglf04DGxuIQUGAnKmuhGlRI6eTJWT6yPz56SLqJ4S9n5VLN3XbmKsOXfdP6pJYlt3mihQy5K4AiO6eNmV2BXaAQCbKrZOuJy8DXezkpxsW25GRiNm+FU93uhl2Kq8x1VcWiKGkf2YMimImjipCKdA3Fdh07nYBqpOdm82Oe8ugX5/JAFu0xZLcUVUk0TAh8lpVd8NqbUn+UasMckwy5A4GzamMuikgstE3yv5G8jPS37Pa0fYlnAUvXhyB/Lnhxpx5I2wnc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(66946007)(83380400001)(966005)(4326008)(76116006)(478600001)(7696005)(186003)(71200400001)(9686003)(26005)(110136005)(54906003)(6506007)(2906002)(5660300002)(52536014)(7416002)(33656002)(122000001)(38100700002)(82960400001)(66556008)(64756008)(66476007)(8676002)(66446008)(41300700001)(8936002)(86362001)(55016003)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGhXWThwdFdGRkpJL3VnSjVITjlWRFpWeXRoazA2QU90UTJHOUhJMHNzVnRM?=
 =?utf-8?B?bHNVSHNvWG42WkV3dEJFcjFITU95eEhIcmZITXc0NWtja1NELzRMUktaNTla?=
 =?utf-8?B?aHRnS2QwQVZYbTBZeERGU092SWlJZTNTKy9ZZVd4ZHVYaXRSNlZuaHQ2UTZC?=
 =?utf-8?B?VmF1KzNyaDkxa05hSXpMUHl2U2pkQzduT28rNHhDNUZFWldzbmZaNHFIMVYw?=
 =?utf-8?B?bHNaKytuZGFjM2xEMkJCL2FoeGQzS1pUV3VyeWZKSGdJUnlWVTA2T2dQK0M1?=
 =?utf-8?B?Tmt4a0ZiZU9rTyt6Sy9Nd1QrSEh3ZjI4ZUIxc2g3bjI2NSthMnhuczF6VklK?=
 =?utf-8?B?TUxod3Z0eXJZTkdlRDlXd005NWExUW9WYS9xM1FtNFJFbHZRUnZsMVd4RElP?=
 =?utf-8?B?WE1PY09ZdWJ1ZE5xOHROY2thSkNINjZCZjNyTmpaV3VyWGpoaDNUVkhMRGZh?=
 =?utf-8?B?SVJjcFZXU2ZEdjdJQUhQaU02eUhsUWFEQzl4a0RvNXR1a0h1eGtuU0JQS0g2?=
 =?utf-8?B?bzlnNUdQQ1lTVFhBZFBHMU1tQVhwdTNCVG1uQ0RyMk5VMmg3WTNvNnRxWlVS?=
 =?utf-8?B?NHRTUDd1TFdhVTdrUEY0ck9HSzdkVVcwMGE3bTVjS3RiVlJtMVFHQjJaMXls?=
 =?utf-8?B?NmpyRE9HSDNyams1eTJIb0FNMHljcEZ6UEVkQzVDSXowWEZFVXNndkdCU21N?=
 =?utf-8?B?OEJlV3poRE9ZMzhrUHVLY1RDcnpSSmRrQnRmb3FXdGlzM0toNnZKcWhtdmNT?=
 =?utf-8?B?RGtqalB2cm9tOWM3a1J4K3I3VWxhRCtmc1dQS2UzZ2Yyb2IwYmJmUTJ1bUZZ?=
 =?utf-8?B?cWx5d0JZcG92UGJIbHROdjRFZDl3cU5LWDJKbmZTVUlWZnJYY3J5MEVEZlNq?=
 =?utf-8?B?SDNFVmJEOUpPbVFycC9QNTdRbUdpTCtWY3M5bjZVUEFXdldiMW9lZDFvaElF?=
 =?utf-8?B?ZzQyd1NidGRlaHZXZDk4RkJmaDVFeWo1Z1R3ZWhJSG81b3p5VGxUN3gxL0tn?=
 =?utf-8?B?SE40clA2TjZsUlN5T0pxMzBGNUVzNjJZd1hvbDVRRDAxZWIxSS94TzFtQ04y?=
 =?utf-8?B?b1E1S0EwOEtOdUZiTFltLzlPRjdEMDZxK2h2U0dTS1ZES29ZQXlCNFJYeUxo?=
 =?utf-8?B?Z3lTMVZPUkVZeWIyOUVpRG9DQzVmaXcyODJWcUI1VEVVa1ljQkIwNTZzN3Ew?=
 =?utf-8?B?MitwWjZOdStJNUQ0YThrOHp1dVlPV1FIVldxWEZ3d2ZLWG5BWUxBak0yOFEy?=
 =?utf-8?B?cExiRmlCT0V4WUpKdWh5d3U1bnc1UDBwNm81VEZ6NjRnVE9NU050SEtpTVVi?=
 =?utf-8?B?Q0hsMnpNL0M0YkdFbThnVzBuZGd6MEp2ZlpLNTFncHZiamJKQTNsNDBPWFg4?=
 =?utf-8?B?NnMxMmNSUVFqWG5DbEx6RzhNc1JPMDdDcFpBTDVCRE51ZnNJK0JRUFAwcExR?=
 =?utf-8?B?bnB6cEFoTHNHK3Y0bUE4SzRJVGloVEhUejlCeGVWamFYRWs0R0dKTkcrYUcw?=
 =?utf-8?B?R3NVSWhzN29HUTdTcHV1VE9YOXlLdUs1clZSaFlJU2tMTTNnOWJ5Vm9hdm1H?=
 =?utf-8?B?c0QxQUZhZE5wUCtkbVF0R05pWHkwMWZMSFdHU1IvWlVqZHFOSVhlZnNzSmwz?=
 =?utf-8?B?ZXkxVVdXOFVzR3FMOVRYazRwVlYwcVNOSkJLUldyc3gyUjRBdGkxMzNKYU1m?=
 =?utf-8?B?WENLR253MENOdE1Xc01zS2xkREZQZTIzVWlmWTNWN29rSVppZjM5QUJhNHpM?=
 =?utf-8?B?NC9PVFNTQTZ6MU1mZGV3eXhETTNQMG5KNXd0V2E1OERQNit2bUNWblorWG0x?=
 =?utf-8?B?OTA2N2dMSXFLdXVWWnNDQlNLN2t3cUpoUFVhQVhpUWp1RTlZOXdQRGtFbFRh?=
 =?utf-8?B?bys4djFiYTJjY2VDbnNnSmJ1blNOdEg2V0pMQWZiRURtWE03SnduUU9CbEo4?=
 =?utf-8?B?d2Rwc2lvZWZNVEZ1VXk2ODQram5wTlpNMHgwUmIyQngzQjNFRUFJN2x1bWh0?=
 =?utf-8?B?VllXVE85Y0RKekl1ekJSQTFEdDltSW9jeW1iOHUrNmkvdll4WmtwYjE0VTRC?=
 =?utf-8?B?bUtJSGlWa0pvZEpqaW5xblhNMWpvNkErOUVyUjVVa2ExTitEeVNnTm50Qys2?=
 =?utf-8?Q?i+M0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff9499c-a427-422d-4e64-08db466d4b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 15:45:42.7611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7VEcwhanrWOg5tK9oNp0CqGfHCsJAnM1+343OwzANO+G6y2wsceyosWdes0Ve6WiLeqoU2tKConomdl1h5mqFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6050
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+PiBUaGFua3MgZm9yIHlvdXIgY29uZmlybSwgYW5kIHdoYXQgeW91ciBvcHRpb24gYWJvdXQg
YWRkDQo+ID4+IE1DRV9JTl9LRVJORUxfQ09QWUlOIHRvIEVYX1RZUEVfREVGQVVMVF9NQ0VfU0FG
RS9GQVVMVF9NQ0VfU0FGRSB0eXBlDQo+ID4+IHRvIGxldCBkb19tYWNoaW5lX2NoZWNrIGNhbGwg
cXVldWVfdGFza193b3JrKCZtLCBtc2csIGtpbGxfbWVfbmV2ZXIpLA0KPiA+PiB3aGljaCBraWxs
IGV2ZXJ5IGNhbGwgbWVtb3J5X2ZhaWx1cmVfcXVldWUoKSBhZnRlciBtYyBzYWZlIGNvcHkgcmV0
dXJuPw0KPiA+DQo+ID4gSSBoYXZlbid0IGJlZW4gZm9sbG93aW5nIHRoaXMgdGhyZWFkIGNsb3Nl
bHkuIENhbiB5b3UgZ2l2ZSBhIGxpbmsgdG8gdGhlIGUtbWFpbA0KPiA+IHdoZXJlIHlvdSBwb3N0
ZWQgYSBwYXRjaCB0aGF0IGRvZXMgdGhpcz8gT3IganVzdCByZXBvc3QgdGhhdCBwYXRjaCBpZiBl
YXNpZXIuDQo+DQo+IFRoZSBtYWpvciBkaWZmIGNoYW5nZXMgaXMgWzFdLCBJIHdpbGwgcG9zdCBh
IGZvcm1hbCBwYXRjaCB3aGVuIC1yYzEgb3V0LA0KPiB0aGFua3MuDQo+DQo+IFsxXQ0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS82ZGMxYjExNy0wMjBlLWJlOWUtN2U1ZS1hMzQ5
ZmZiN2QwMGFAaHVhd2VpLmNvbS8NCg0KVGhlcmUgc2VlbSB0byBiZSBhIGZldyBtaXNjb25jZXB0
aW9ucyBpbiB0aGF0IG1lc3NhZ2UuIE5vdCBzdXJlIGlmIGFsbCBvZiB0aGVtDQp3ZXJlIHJlc29s
dmVkLiAgSGVyZSBhcmUgc29tZSBwZXJ0aW5lbnQgcG9pbnRzOg0KDQo+Pj4gSW4gbXkgdW5kZXJz
dGFuZGluZywgYW4gTUNFIHNob3VsZCBub3QgYmUgdHJpZ2dlcmVkIHdoZW4gTUMtc2FmZSBjb3B5
IA0KPj4+IHRyaWVzDQo+Pj4gdG8gYWNjZXNzIHRvIGEgbWVtb3J5IGVycm9yLiAgU28gSSBmZWVs
IHRoYXQgd2UgbWlnaHQgYmUgdGFsa2luZyBhYm91dA0KPj4+IGRpZmZlcmVudCBzY2VuYXJpb3Mu
DQoNClRoaXMgaXMgd3JvbmcuIFRoZXJlIGlzIHN0aWxsIGEgbWFjaGluZSBjaGVjayB3aGVuIGEg
TUMtc2FmZSBjb3B5IGRvZXMgYSByZWFkDQpmcm9tIGEgbG9jYXRpb24gdGhhdCBoYXMgYSBtZW1v
cnkgZXJyb3IuDQoNClRoZSByZWNvdmVyeSBmbG93IGluIHRoaXMgY2FzZSBkb2VzIG5vdCBpbnZv
bHZlIHF1ZXVlX3Rhc2tfd29yaygpLiBUaGF0IGlzIG9ubHkNCnVzZWZ1bCBmb3IgbWFjaGluZSBj
aGVjayBleGNlcHRpb25zIHRha2VuIGluIHVzZXIgY29udGV4dC4gVGhlIHF1ZXVlZCB3b3JrIHdp
bGwNCmJlIGV4ZWN1dGVkIHRvIGNhbGwgbWVtb3J5X2ZhaWx1cmUoKSBmcm9tIHRoZSBrZXJuZWws
IGJ1dCBpbiBwcm9jZXNzIGNvbnRleHQgKG5vdA0KZnJvbSB0aGUgbWFjaGluZSBjaGVjayBleGNl
cHRpb24gc3RhY2spIHRvIGhhbmRsZSB0aGUgZXJyb3IuDQoNCkZvciBtYWNoaW5lIGNoZWNrcyB0
YWtlbiBieSBrZXJuZWwgY29kZSAoTUMtc2FmZSBjb3B5IGZ1bmN0aW9ucykgdGhlIHJlY292ZXJ5
DQpwYXRoIGlzIGhlcmU6DQoNCiAgICAgICAgICAgICAgICBpZiAobS5rZmxhZ3MgJiBNQ0VfSU5f
S0VSTkVMX1JFQ09WKSB7DQogICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWZpeHVwX2V4Y2Vw
dGlvbihyZWdzLCBYODZfVFJBUF9NQywgMCwgMCkpDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG1jZV9wYW5pYygiRmFpbGVkIGtlcm5lbCBtb2RlIHJlY292ZXJ5IiwgJm0sIG1zZyk7
DQogICAgICAgICAgICAgICAgfQ0KDQogICAgICAgICAgICAgICAgaWYgKG0ua2ZsYWdzICYgTUNF
X0lOX0tFUk5FTF9DT1BZSU4pDQogICAgICAgICAgICAgICAgICAgICAgICBxdWV1ZV90YXNrX3dv
cmsoJm0sIG1zZywga2lsbF9tZV9uZXZlcik7DQoNClRoZSAiZml4dXBfZXhjZXB0aW9uKCkiIGVu
c3VyZXMgdGhhdCBvbiByZXR1cm4gZnJvbSB0aGUgbWFjaGluZSBjaGVjayBoYW5kbGVyDQpjb2Rl
IHJldHVybnMgdG8gdGhlIGV4dGFibGVbXSBmaXh1cCBsb2NhdGlvbiBpbnN0ZWFkIG9mIHRoZSBp
bnN0cnVjdGlvbiB0aGF0IHdhcw0KbG9hZGluZyBmcm9tIHRoZSBtZW1vcnkgZXJyb3IgbG9jYXRp
b24uDQoNCldoZW4gdGhlIGV4Y2VwdGlvbiB3YXMgZnJvbSBvbmUgb2YgdGhlIGNvcHlfZnJvbV91
c2VyKCkgdmFyaWFudHMgaXQgbWFrZXMNCnNlbnNlIHRvIGFsc28gZG8gdGhlIHF1ZXVlX3Rhc2tf
d29yaygpIGJlY2F1c2UgdGhlIGtlcm5lbCBpcyBnb2luZyB0byByZXR1cm4NCnRvIHRoZSB1c2Vy
IGNvbnRleHQgKHdpdGggYW4gRUZBVUxUIGVycm9yIGNvZGUgZnJvbSB3aGF0ZXZlciBzeXN0ZW0g
Y2FsbCB3YXMNCmF0dGVtcHRpbmcgdGhlIGNvcHlfZnJvbV91c2VyKCkpLg0KDQpCdXQgaW4gdGhl
IGNvcmUgZHVtcCBjYXNlIHRoZXJlIGlzIG5vIHJldHVybiB0byB1c2VyLiBUaGUgcHJvY2VzcyBp
cyBiZWluZw0KdGVybWluYXRlZCBieSB0aGUgc2lnbmFsIHRoYXQgbGVhZHMgdG8gdGhpcyBjb3Jl
IGR1bXAuIFNvIGV2ZW4gdGhvdWdoIHlvdQ0KbWF5IGNvbnNpZGVyIHRoZSBwYWdlIGJlaW5nIGFj
Y2Vzc2VkIHRvIGJlIGEgInVzZXIiIHBhZ2UsIHlvdSBjYW4ndCBmaXgNCml0IGJ5IHF1ZXVlaW5n
IHdvcmsgdG8gcnVuIG9uIHJldHVybiB0byB1c2VyLg0KDQpJIGRvbid0IGhhdmUgYW4gd2VsbCB0
aG91Z2h0IG91dCBzdWdnZXN0aW9uIG9uIGhvdyB0byBtYWtlIHN1cmUgdGhhdCBtZW1vcnlfZmFp
bHVyZSgpDQppcyBjYWxsZWQgZm9yIHRoZSBwYWdlIGluIHRoaXMgY2FzZS4gTWF5YmUgdGhlIGNv
cmUgZHVtcCBjb2RlIGNhbiBjaGVjayBmb3IgdGhlDQpyZXR1cm4gZnJvbSB0aGUgTUMtc2FmZSBj
b3B5IGl0IGlzIHVzaW5nIGFuZCBoYW5kbGUgaXQgaW4gdGhlIGVycm9yIHBhdGg/DQoNCi1Ub255
DQo=
