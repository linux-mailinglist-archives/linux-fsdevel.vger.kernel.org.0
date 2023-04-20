Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15BA6E87C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 04:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjDTCDv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 22:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjDTCDt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 22:03:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CA13A96;
        Wed, 19 Apr 2023 19:03:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JL4iVo013630;
        Thu, 20 Apr 2023 02:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aRw9qPNmIzFjhTVzIb2rPmWIioAjH7lOsSmrshYuJ38=;
 b=s5udNpyAvHlSjbY/5snTa4/X3Vryf3ivbhQ/+Kv4LcQQsMBo3FYTQ7QDJJP0W564k4UL
 RsED33sdN6cazHjW3Cu1YI11sytvnRtQTCxjmAH7K4wxqVnsLJcWkjTOvm2MfaplM7Rn
 oXrN+dN7+HuSl33b6jbD+o9JArqWHfgUlXFik/fi9fLTDEFJtp9HONSX6xAoVDH6byQj
 edWWwKj0QfGj4Ci/mP9RDoUEK5Z7MM/eUYTclIY+kc1+Ubn/in8D8B48FbWZqz27Xr2C
 FQrKMez9PnkglnsvjtbLgMXYwHsznuP0Hhhaw/Fmu2hMVXHpQbKRY6gxiqcUVuDhJoSh +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pymfuhpqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 02:03:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33JNUEEv015677;
        Thu, 20 Apr 2023 02:03:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjcdpmks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Apr 2023 02:03:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKsROmTkEmO6qX+LhV71CB0eVT+tLm+FjURbIYRAmqmd05107+vP0Jp1403PPjr3xVP+mrp3SbSoHl3p3SuBpcgBRnYAgeVsPaHV0H5qZ93LD5Iv5zzkosQ9C81Xv0WHalbGmnKjL3tzu9ocpnDB6E+SSRAdAQfNU0bYl4RXPJMlQwQb4vgNhBqlQbBl/MYHLA/loS0FsB87ctRD5TvyM1RNLZ7Os6NPzPbODNKVU7znljNmbGPD8oISML/bSxm0Ykn+R406NLpdgxk4ILvkAIrLpU/2UtSFiHXM6cKlsAYRsXSRoFXlRqzaFz73xfHpG+WpHIkj0LC1se8VB53kEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRw9qPNmIzFjhTVzIb2rPmWIioAjH7lOsSmrshYuJ38=;
 b=CJmPN/ektyWCU2tD/ia0gFNIfG8o0AjKsQiEmz8jGmVAKOvCWHJ81Lr8tUDPZn53114Rb6lnXZ6Mf3mVoc1zsSpo2P60Vp4LxMkplSwUoUY5Ep4xSr1F0Lf+Koo3cgkdrP8wVBaEhy7vMlo/N6JOSoDmiWxEKIDyEMwvUbbaZo724SJDgDkLs1hCzre6TBJamFgpvkiYlXLpHdO/sTHq7MpdniSS8/0dlN1JB1rUeb5RqEXJOlk5ZDV1NTxvWCXH2Lt6jwp8wWlv6vNgSjLf5tZc2wYwittjvgYHlsogWR2WqGjepiXDb7T/ujITNumLGto/ce2L8bv8tLAqEtpN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRw9qPNmIzFjhTVzIb2rPmWIioAjH7lOsSmrshYuJ38=;
 b=qB/EgLeSoEYMXHxMeordHhOx9l2VLUbY/EF/G8RJzkuVnNM2e/olrELzTG7YEq4kNdEBXYKei9pnnNBCa7e5+tB0IoDvagDj82mnuY8fdlxJSQPgunluhZPSzxf8wkZz+c/Xb7XYBG1wdEm7c9XR5mhAqlMU8lwfYyxx1q34XGc=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH7PR10MB5771.namprd10.prod.outlook.com (2603:10b6:510:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 20 Apr
 2023 02:03:09 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9%5]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 02:03:09 +0000
Message-ID: <7d0c38a9-ed2a-a221-0c67-4a2f3945d48b@oracle.com>
Date:   Wed, 19 Apr 2023 19:03:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] mm: hwpoison: coredump: support recovery from
 dump_user_range()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20230417045323.11054-1-wangkefeng.wang@huawei.com>
 <20230418031243.GA2845864@hori.linux.bs1.fc.nec.co.jp>
 <54d761bb-1bcc-21a2-6b53-9d797a3c076b@huawei.com>
 <20230419072557.GA2926483@hori.linux.bs1.fc.nec.co.jp>
 <9fa67780-c48f-4675-731b-4e9a25cd29a0@huawei.com>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <9fa67780-c48f-4675-731b-4e9a25cd29a0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:5:100::46) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|PH7PR10MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: e71f26e2-0fa2-416c-1812-08db41436335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBeC1oblcs8BUwiC2xRIuqnmSAfAdoa5LR8vrQ46Rl2K8y/dpA7BJF6AetxN1IVMV3Jo6rumdMdEWiFShu1ASRgk9R4gan3jge4dXtzrKFnDnADeZ/xmKbvCItsOjVjQi8hdPHUDwTA1spMO9fDHGgw12EROuuC6Fv2Ijh+oKVkuyit2mwoeOdCmJOAjfBe2PmTFz5WY/zi5cTIrva70AMtvBEKcuTxDIKGRiqZDOVIuXj6kXltVi62oNvrRQ+RwRDObaSrG5l3zZdLORTpP18MzhQKyMkvM/7hGqgQmL0sw+8kpnUG77OSmbs/KjpO8y+ROeiPfoFtRrDelyh8yJFu7RlTCyiAnY4MtM2p6JWusZHc7kuWBjg4cmYJF670UFbJ4aBhw6VogPH90aw2NgmUoaweOfR1nUvmWjv+ifAw8X8d1Y1dqDu9W7chw+NenY6NaVv+nZrZkHenQCgK1JUC+LNLTOLyfN179h5dkUxWuturdjgyfx3pagQMIcKvbycapPA5pY6CYpJ8TFfH5wiXhkEWTBkUJe9zx1HsUB7YT41RYQbCH3wk5LYRYyoC5LBeXPVlfDvLWm5OrrltIWGc1luPPBP3a7jGF35Yq1xidCQSO5ZGPYQUhg4kV4fYvQ491uUXSoHxmTiPT4z2R8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(44832011)(54906003)(6506007)(6512007)(186003)(26005)(53546011)(478600001)(110136005)(2906002)(8936002)(8676002)(7416002)(83380400001)(5660300002)(2616005)(86362001)(38100700002)(316002)(4326008)(66556008)(66476007)(66946007)(31696002)(41300700001)(6486002)(31686004)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXVSS0FiTHVYc3FwNWJKV2s1WVhCK1d0Y0tZYnZabmlJK0FYOXd2dWRhLzdv?=
 =?utf-8?B?L0ZCOGpsQk5Qc2Z4dVRRRktjbVlMRmtVQ2kraXVtdWxKVmZuMlNZS3J2TmZW?=
 =?utf-8?B?aXpjYVA2RnFPNmZnT2w2azBqTDNDbURFb2RLUTFtUXVUR0NYK1NwY2k0SlVG?=
 =?utf-8?B?U2N1RXFqTHRnUXVUNkhsSVZaNWtSd0xWbzl6VG1uVEJsZFZmTkp3L0lYT092?=
 =?utf-8?B?Yks4WEZpQm1QS1lUb1lyZHVicVJWa3dCS2lNRkdrVWVieEJNV3BiUVhESEx5?=
 =?utf-8?B?aXJJV29lWE9YSlZNNWVlbVBNSnBIRlMzcG1xZ0JtZFVzaXlMS3lrUjBhYzA0?=
 =?utf-8?B?YzFpbFdxT2tHZGt0OUNkRDNrQWpTVERoRkMzdHhoNjY0QzIxejVVdjVPQXJD?=
 =?utf-8?B?eWE0NFgxVm14Q1ljKzlOSTAwTTl3VEdyeHEzbkdydGdMVXgyRkVvQStPbWlt?=
 =?utf-8?B?NjB4VTM0QlhRZVB4bUMxaUNaTXlITzE0S2VkUHFuMFZoVmNKb1Y0TVUwc1B0?=
 =?utf-8?B?RFdPSFRoWlNVQ2xQcnl5VTlMdHM2VVphYlhrazREWERoTVAvUWhlc2tRRDZR?=
 =?utf-8?B?NmlKdjRVdm5SdHgzZDFWbzVFN054Q0Z6WmkweXRpY0RGYXZnUjJpSVhxeU1p?=
 =?utf-8?B?NlJ2RTFYMEJ3c1RicXBPNDlZY3dpemdhNk5Hb0pvRDRXeFNEbHFJSEFOcTg3?=
 =?utf-8?B?TU5jL25SOUhFNFNPU3VNZWcxZXNhVTZRTUhZSkVhWFp5UlFmS3BkSDFWSmRN?=
 =?utf-8?B?UGtRUFN0SnVOckkvWjdWd0E2QTFUY2NQT2FzczI3ODRMQXZUb2JTQjVZVElx?=
 =?utf-8?B?aWxkalFzeitiNnVEb0Z3NldzT3pnT1dETFlqRVBwOTIwb3VrbjBiVW1pU0Ri?=
 =?utf-8?B?T0RkTHdZZjUxRWpEaHBRbXgrME4zL0RPTW0zb1V2VW9PY2ZtOWhJcWNTMUJa?=
 =?utf-8?B?OWtUNmJhSjRnclc1alpoNTFYaTNOcWtVbFpXVCtrdlh2V201S0xHM3ZqWXl1?=
 =?utf-8?B?WVUvZ0FHMktVdWdPMkpDazdHR0g4dnhIWEJlUDhQZFMzMWVSVFd2bkpienJM?=
 =?utf-8?B?ckwzMXN0L0grbkNSUVVCQ3pWK2pUNUczdldsOVpGdUFhdEtEMTNhem5kU1Yv?=
 =?utf-8?B?N1ZJdzhnd2s2VTlVSHdLTTlya0xpR2h2QUJ6QXZFKzhpK3NtRHVCaGFKblVx?=
 =?utf-8?B?ZnpORDR1Z0d5b09yMnRxQ2xiUGwyaHRycTlGZk9vSkFxS2t1Y1lqWlFlWTdE?=
 =?utf-8?B?UUlkNWlibDNCQndoS28zbk1Rb29FaG1WTWNmNzlBNE16NHdrTURBUlNTeW43?=
 =?utf-8?B?RTRFbHcvYlZISGsyT2lBdFhtcmdBSnZNRHRoQkUzQmxFTStRdUJOWEQ5Ukxh?=
 =?utf-8?B?S1VCUU54TlJnYWh6dUFzekRwVjBQTnhJOC9wT3JqM1NUekpDR01pTnlPdWhx?=
 =?utf-8?B?bU5wQ3lraUR6SHBLdW1GdEQ1Z1M3ZVI3V2haSEdLanRPY0ZjWE1UamlsWnkr?=
 =?utf-8?B?Y3RSb1I5TXNoUTBlWmo1VG9Oa0duanBaRFRqTlViMkQ4MGVpZWpkUjVzSy9z?=
 =?utf-8?B?S3k0SUVWOVVMYzJHaG1yVUVnVXhsb3FJR0xYQ0V4Ky9ubjFjZ1dwcVF4Q3VI?=
 =?utf-8?B?bm1lblhqekFNZ2VjeEp3VEZwb2UwT3NJN01jYmNiOXppV2J2bGV2Qm1keEdC?=
 =?utf-8?B?ZlpsTG5PK2pWRHlRZXg5UnVZeXc4UHEzVHYzUlVucWlqMEJVN2ZxOXZWWlgr?=
 =?utf-8?B?Tks5K0o5eCs2UGZFNEMxUHhBRmQ5WlNGOFVBSWFvaC9uQ2hVbFFWSFhRY3Bl?=
 =?utf-8?B?MHN1U2M4OUp3Mmh2WHNaUXM4bmpNWnFhODFFbzMyZ0tJTnArVndqSjZLUHY2?=
 =?utf-8?B?MHRncXF0RVBzSHgzU09sSTRYTnNqNXJDRG1ZK2NNVi9neWYwSzc3WWREeFJD?=
 =?utf-8?B?ZzBVSEoxdGsxOGdheFdEOGpwZWhUWEUyY2lNaXdpWVZKVy93QWpqZmVYMHBL?=
 =?utf-8?B?VFVnK2dkcmo5clBmSVlHNFdFaklEckFSVUM5R3doQ3VuR3grUkQzMWY5WGlC?=
 =?utf-8?B?SjVRMFNPbzc1dm5zY3UxL3J1NUs0N3JPbUwzTU1EN3pLaHl2Z3lPZVlGZjNq?=
 =?utf-8?Q?sA2Lx8xCTc9b9H6FxeP90VLCg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?enNzemg2SEJ4QlZTdUxSTzJQTlJZblpkZHJVWGZSMVRrZVFqUDFQSExEZjJk?=
 =?utf-8?B?Vy9RK1ZqYSt0dXVwZVc4QWpaUkd6S2gzaFBZK3lZWXpTcHJBTmtZQUZ0UEor?=
 =?utf-8?B?UkZJbDVEUFBNOEFOODFpdlB4dWJPZG55NFZOK0YwbWRkZVk0SnN5cU1aS0hk?=
 =?utf-8?B?Y01nSFZJTEFyQ01FSyszV3JwdHJmdFU3dVdKZm5wVE5nZGhZWVFBVWY1dHd3?=
 =?utf-8?B?SVB3SHd1aUV0YTZFLzV3OERuTmsxbjZkamdpTlE3SXN4UzBWZURnZ2lGdlZZ?=
 =?utf-8?B?L1BxRDhLWFI2UEJOVVB4YUtPUTBMRHBQOUVJSXVDV1YyMzlpQ1NYMGpVZXRs?=
 =?utf-8?B?L0VMNE83TFYrRkpQRzVkcXVkNy9qaU5lZzg3Ty9DbjYxTVlTbTBwZ0J3eE4r?=
 =?utf-8?B?TzdSc210aE1VRVZCWko1TUg5RXhraXdPMVFWYmNXQndCaVJFWG5aYkkwa1A4?=
 =?utf-8?B?Y0M4QnRXdVdKQVV0UHFoM01Wb0RRaHduYnkveFh6d0hDUnFOajN4cUxFcHdD?=
 =?utf-8?B?dStIY0ZLM2Y1YWRjNUZDN0VqRzJPbmZ6TEVmOC9HaWo5dmFZekF0ZlVINGRo?=
 =?utf-8?B?MGZOK3RVZEY4Rjk1V0xZaEtMeFgxbHAwQzZxeWpLVTR2Vy8xMVZOL09jclI4?=
 =?utf-8?B?RDRmUjNqaEh0NW9uUnFBSzVkU0ZrOGNuYklHaUxTWkE2Y0tUL05vc2J2cWZm?=
 =?utf-8?B?bTZPU1FINUJNSjRJZUVpTzJNazZNUjRVQ2ZvYnpOWnhmUzc0WEJob1JBSWYr?=
 =?utf-8?B?NXRxcnR6dFFuc3BsQTZ2OElqaDgvVnY1T0VjV3hIRkY0MWRXRXpjMEdEd0Fp?=
 =?utf-8?B?WjZQdk5tL2FaL1Zqd1Z4MndiVzFQMVA5YXZjb1F1dm1nblUrbUlQamdjR2hl?=
 =?utf-8?B?RWNwajhLYjh4Smw3dTNXWEtuSVZjN0RLZE4wbzYrU1VXbytsYmtVdXRCNG5y?=
 =?utf-8?B?ZHlORzlyRUcwRHpZZXA2L2RXRmJaSmIzalRQRU4rT0JQTFZ3YXdMRHRFcHI3?=
 =?utf-8?B?K2JOTmdudjFydXU0S0taTFJsWGhXQUlGTFFwbVUzRUNXMGNkY2c4cDE4WlVj?=
 =?utf-8?B?UGhzYlZNNUtjYXhxSXBlNDB1enFySldzN0sycEVGQXA5bzl2QS9iWEdoNXQ0?=
 =?utf-8?B?MTdoaVEwdDFVNDNDb1lNQlowV1dYeE5rMTV5eXhpWEx6Q1Vkejg1ZDBVZm1a?=
 =?utf-8?B?VWN3Y0FhRHhtOUFScmY5dHFjZThnL2I5TGlmczZJa3Z3M1E1UTZLdG8zd2Rn?=
 =?utf-8?B?QnZsako0Y2FyUG5sdjhvVFJOUUNZYTYrVU5xOC82NDhXdDhKY09zVjZ5MnNt?=
 =?utf-8?Q?ao+0IvtudNZiuoDXoikOqAbes6UhEKDVgf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71f26e2-0fa2-416c-1812-08db41436335
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 02:03:08.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1kq34NGtMbUfYFyDi8tawjHdwpHB0PVMqLOANcqW6oWU2SU95P2lYVp04x2t7wanUIe7CxCM7t2vsF9iFUpqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_16,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200014
X-Proofpoint-GUID: 3ciNLUwP5UTxViD_9uHCC-qpnWnZ5Elu
X-Proofpoint-ORIG-GUID: 3ciNLUwP5UTxViD_9uHCC-qpnWnZ5Elu
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/19/2023 5:03 AM, Kefeng Wang wrote:
> 
> 
> On 2023/4/19 15:25, HORIGUCHI NAOYA(堀口 直也) wrote:
>> On Tue, Apr 18, 2023 at 05:45:06PM +0800, Kefeng Wang wrote:
>>>
>>>
>>> On 2023/4/18 11:13, HORIGUCHI NAOYA(堀口 直也) wrote:
>>>> On Mon, Apr 17, 2023 at 12:53:23PM +0800, Kefeng Wang wrote:
>>>>> The dump_user_range() is used to copy the user page to a coredump 
>>>>> file,
>>>>> but if a hardware memory error occurred during copy, which called from
>>>>> __kernel_write_iter() in dump_user_range(), it crashes,
>>>>>
>>>>>     CPU: 112 PID: 7014 Comm: mca-recover Not tainted 6.3.0-rc2 #425
>>>>>     pc : __memcpy+0x110/0x260
>>>>>     lr : _copy_from_iter+0x3bc/0x4c8
>>>>>     ...
>>>>>     Call trace:
>>>>>      __memcpy+0x110/0x260
>>>>>      copy_page_from_iter+0xcc/0x130
>>>>>      pipe_write+0x164/0x6d8
>>>>>      __kernel_write_iter+0x9c/0x210
>>>>>      dump_user_range+0xc8/0x1d8
>>>>>      elf_core_dump+0x308/0x368
>>>>>      do_coredump+0x2e8/0xa40
>>>>>      get_signal+0x59c/0x788
>>>>>      do_signal+0x118/0x1f8
>>>>>      do_notify_resume+0xf0/0x280
>>>>>      el0_da+0x130/0x138
>>>>>      el0t_64_sync_handler+0x68/0xc0
>>>>>      el0t_64_sync+0x188/0x190
>>>>>
>>>>> Generally, the '->write_iter' of file ops will use 
>>>>> copy_page_from_iter()
>>>>> and copy_page_from_iter_atomic(), change memcpy() to 
>>>>> copy_mc_to_kernel()
>>>>> in both of them to handle #MC during source read, which stop coredump
>>>>> processing and kill the task instead of kernel panic, but the source
>>>>> address may not always a user address, so introduce a new copy_mc 
>>>>> flag in
>>>>> struct iov_iter{} to indicate that the iter could do a safe memory 
>>>>> copy,
>>>>> also introduce the helpers to set/cleck the flag, for now, it's only
>>>>> used in coredump's dump_user_range(), but it could expand to any other
>>>>> scenarios to fix the similar issue.
>>>>>
>>>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>>>> Cc: Christian Brauner <brauner@kernel.org>
>>>>> Cc: Miaohe Lin <linmiaohe@huawei.com>
>>>>> Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>>> Cc: Tong Tiangen <tongtiangen@huawei.com>
>>>>> Cc: Jens Axboe <axboe@kernel.dk>
>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>> ---
>>>>> v2:
>>>>> - move the helper functions under pre-existing CONFIG_ARCH_HAS_COPY_MC
>>>>> - reposition the copy_mc in struct iov_iter for easy merge, suggested
>>>>>     by Andrew Morton
>>>>> - drop unnecessary clear flag helper
>>>>> - fix checkpatch warning
>>>>>    fs/coredump.c       |  1 +
>>>>>    include/linux/uio.h | 16 ++++++++++++++++
>>>>>    lib/iov_iter.c      | 17 +++++++++++++++--
>>>>>    3 files changed, 32 insertions(+), 2 deletions(-)
>>>>>
>>>> ...
>>>>> @@ -371,6 +372,14 @@ size_t _copy_mc_to_iter(const void *addr, 
>>>>> size_t bytes, struct iov_iter *i)
>>>>>    EXPORT_SYMBOL_GPL(_copy_mc_to_iter);
>>>>>    #endif /* CONFIG_ARCH_HAS_COPY_MC */
>>>>> +static void *memcpy_from_iter(struct iov_iter *i, void *to, const 
>>>>> void *from,
>>>>> +                 size_t size)
>>>>> +{
>>>>> +    if (iov_iter_is_copy_mc(i))
>>>>> +        return (void *)copy_mc_to_kernel(to, from, size);
>>>>
>>>> Is it helpful to call memory_failure_queue() if copy_mc_to_kernel() 
>>>> fails
>>>> due to a memory error?
>>>
>>> For dump_user_range(), the task is dying, if copy incomplete size, the
>>> coredump will fail and task will exit, also memory_failure will
>>> be called by kill_me_maybe(),
>>>
>>>   CPU: 0 PID: 1418 Comm: test Tainted: G   M               6.3.0-rc5 #29
>>>   Call Trace:
>>>    <TASK>
>>>    dump_stack_lvl+0x37/0x50
>>>    memory_failure+0x51/0x970
>>>    kill_me_maybe+0x5b/0xc0
>>>    task_work_run+0x5a/0x90
>>>    exit_to_user_mode_prepare+0x194/0x1a0
>>>    irqentry_exit_to_user_mode+0x9/0x30
>>>    noist_exc_machine_check+0x40/0x80
>>>    asm_exc_machine_check+0x33/0x40
>>
>> Is this call trace printed out when copy_mc_to_kernel() failed by finding
>> a memory error (or in some testcase using error injection)?
> 
> I add dump_stack() into memory_failure() to check whether the poisoned
> memory is called or not, and the call trace shows it do call
> memory_failure()， but I get confused when do the test.
> 
>> In my understanding, an MCE should not be triggered when MC-safe copy 
>> tries
>> to access to a memory error.  So I feel that we might be talking about
>> different scenarios.
>>
>> When I questioned previously, I thought about the following scenario:
>>
>>    - a process terminates abnormally for any reason like segmentation 
>> fault,
>>    - then, kernel tries to create a coredump,
>>    - during this, the copying routine accesses to corrupted page to read.
>>
> Yes, we tested like your described,
> 
> 1) inject memory error into a process
> 2) send a SIGABT/SIGBUS to process to trigger the coredump
> 
> Without patch, the system panic, and with patch only process exits.
> 
>> In this case the corrupted page should not be handled by memory_failure()
>> yet (because otherwise properly handled hwpoisoned page should be ignored
>> by coredump process).  The coredump process would exit with failure with
>> your patch, but then, the corrupted page is still left unhandled and can
>> be reused, so any other thread can easily access to it again.
> 
> As shown above, the corrupted page will be handled by memory_failure(), 
> but what I'm wondering,
> 1) memory_failure() is not always called
> 2) look at the above call trace, it looks like from asynchronous
>     interrupt, not from synchronous exception, right?
> 
>>
>> You can find a few other places (like __wp_page_copy_user and 
>> ksm_might_need_to_copy)
>> to call memory_failure_queue() to cope with such unhandled error pages.
>> So does memcpy_from_iter() do the same?
> 
> I add some debug print in do_machine_check() on x86:
> 
> 1) COW,
>    m.kflags: MCE_IN_KERNEL_RECOV
>    fixup_type: EX_TYPE_DEFAULT_MCE_SAFE
> 
>    CPU: 11 PID: 2038 Comm: einj_mem_uc
>    Call Trace:
>     <#MC>
>     dump_stack_lvl+0x37/0x50
>     do_machine_check+0x7ad/0x840
>     exc_machine_check+0x5a/0x90
>     asm_exc_machine_check+0x1e/0x40
>    RIP: 0010:copy_mc_fragile+0x35/0x62
> 
>    if (m.kflags & MCE_IN_KERNEL_RECOV) {
>            if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
>                    mce_panic("Failed kernel mode recovery", &m, msg);
>    }
> 
>    if (m.kflags & MCE_IN_KERNEL_COPYIN)
>            queue_task_work(&m, msg, kill_me_never);
> 
> There is no memory_failure() called when
> EX_TYPE_DEFAULT_MCE_SAFE, also EX_TYPE_FAULT_MCE_SAFE too,
> so we manually add a memory_failure_queue() to handle with
> the poisoned page.
> 
> 2） Coredump,  nothing print about m.kflags and fixup_type,
> with above check, add a memory_failure_queue() or memory_failure() seems
> to be needed for memcpy_from_iter(), but it is totally different from
> the COW scenario
> 
> 
> Another question, other copy_mc_to_kernel() callers, eg,
> nvdimm/dm-writecache/dax, there are not call memory_failure_queue(),
> should they need a memory_failure_queue(), if so, why not add it into
> do_machine_check() ?

In the dax case, if the source address is poisoned, and we do follow up 
with memory_failure_queue(pfn, flags), what should the value of the 
'flags' be ?

thanks,
-jane

> 
> Thanks.
> 
> 
> 
>>
>> Thanks,
>> Naoya Horiguchi
> 
