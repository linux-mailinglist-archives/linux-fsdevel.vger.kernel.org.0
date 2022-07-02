Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E025F563D03
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jul 2022 02:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiGBAXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 20:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiGBAXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 20:23:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4EE37A22;
        Fri,  1 Jul 2022 17:23:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261Nxx23015174;
        Sat, 2 Jul 2022 00:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CFGExt3rDk7stt2mr+fIGvzjQyZUO3bqldsy6Sr/6mM=;
 b=omOFodyKEu+OYOsU+2nLjQx0dGDDK48kZnRUusMu+0FuvTxfiN80v9NiLOC/Wdp/eQTk
 uPAHZXdSVMsnXLuDPNRK+fg578OqY7bwj81Y8m76L3LLFvxQL1PSoIQtcOQ5HF/uMUm2
 Om4IqnSMIvJMD/Q8iybo3W/808Hc4MKIvzTdsgXVM9+r/K9AX1oiEJvTqqWYXCaaXdR3
 xwkQqLqZ4riSXepvwOnOZMQboGHHItiwWI0VMq814dgk+J8iEIGHq5fsyv5XrApv7QU/
 wIpqsFUgQsdv0qHH+uOiOV7Et2HC7G+vwzzW5s/gPoMsJ/8kSGjrs+mGHZpODURQ7vIj eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwugjep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Jul 2022 00:22:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2620B22u003636;
        Sat, 2 Jul 2022 00:22:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt5javb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Jul 2022 00:22:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD9HAvQAWWkGBosuaBsXzmGdrgwIYt1MfY0sS/G148wsWtLCO/+/iuGscMurTrnueMUAjqjxYQsf/7ZuiOfMqnOaW9FQQajfwglvI39ulBUUmMi73WB5AHsMye7A5p2UfZycjfGBKtxAGbWNkou5zHjEl1rHGxuwuxc7zvQWXpxrQ+VlQXC19aCRzp6GRxcqUgRknMIKWcf5bFxm2jqadDMyoI/uqvnyZAPJ0xoFfw/yG7o83phX2r2B2qLgrJJIXSWzTqOTLj+flRwjNiJhyScN/qxqwJswvJIlAQRQnWNaggWe4uLr+7ZeiCJSvL0rKa5Hx6OWGO+6MZwejwuwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFGExt3rDk7stt2mr+fIGvzjQyZUO3bqldsy6Sr/6mM=;
 b=VB4yOCS3Y/JdKCq8N3yD4br7X55EYAQ7kkQZorA5GWESs1pVxQQUNkkaJP8nMnMy/PI0cZ6RVC7ZnaogVBwYveQGlX/TLwf7V2FCNs78n4wqjukXfJ0YH/EoJHeUAPkSovGd4V/4hdBkSmgWIRLy/iIAhXef4qP9g5JbR1G0opSoM1/UO2gz+1IHJYP+FUa3kkd/RzXTGMuF6UyooF9oMNYYdqEDBZcLKXd9QjlRoRu+1sLbU3Hqtz6zP53wbd8eI1UaRAIDxDXKp9nTa/Te71JYksAcsW8stf0sDryDMZsdCNMvVpIsxgjOQR8zTGF38bkSG6AMF0SuTR1RkQ3j8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFGExt3rDk7stt2mr+fIGvzjQyZUO3bqldsy6Sr/6mM=;
 b=ZavubVuerTA9lc0YzJeKmLM6XStD0y13YmbZ/BV4MIRN/29HjIT+sGDCLaRcZzYI5fYqEcZnw3REjCPS4rw4Fb+N7yMoUKxLhCOgoEFSS/IQJtKx2atzCh+FruM8fxTHcb+xoPA4oo7dZqtquRKQ1sRoXwdR687+kP2Xvi0dyGE=
Received: from MN2PR10MB3231.namprd10.prod.outlook.com (2603:10b6:208:123::12)
 by CY4PR10MB1256.namprd10.prod.outlook.com (2603:10b6:910:8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Sat, 2 Jul
 2022 00:22:00 +0000
Received: from MN2PR10MB3231.namprd10.prod.outlook.com
 ([fe80::7879:4428:81d2:d221]) by MN2PR10MB3231.namprd10.prod.outlook.com
 ([fe80::7879:4428:81d2:d221%7]) with mapi id 15.20.5395.015; Sat, 2 Jul 2022
 00:22:00 +0000
Message-ID: <bd424825-5d19-a569-d267-0f9dcf382358@oracle.com>
Date:   Fri, 1 Jul 2022 18:22:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/9] mm/mshare: make msharefs writable and support
 directories
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <397ad80630444b90877625a1e94dd81392fc678e.1656531090.git.khalid.aziz@oracle.com>
 <Yr4tM2oOF9rlwWdV@ZenIV>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <Yr4tM2oOF9rlwWdV@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To MN2PR10MB3231.namprd10.prod.outlook.com
 (2603:10b6:208:123::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3a0ef8e-b95c-44b4-ff0d-08da5bc0e177
X-MS-TrafficTypeDiagnostic: CY4PR10MB1256:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmUSvrf/QZe1fmMiJfHhg/hkkxL2ndLu8WXEPaTfdD+lprmnldim9loU2p13VpiBfU6h4C7Kj8kz4vpJYiHamYH8jakvtCREq7Su5bUvYkb3y4LzNT/pyfd6/lG1WlR19YEHHpmvLAariFKNI/UNxT2FQs1Nr6fJlwxSRz76/d7e0jKgcBeDVL3WNCx09+EgQ7gT4a3TvHd8+WtOLBkN2CHaJdGZy5kKv4QTUA/nwtAzm4qPdzELVlTA6fo4s+4cRmCIwatNiN9Ken1ESoksJ7VBeQ8SzuIwnFQjRz+34q4NYHdawrl/SFak0P6jEC49tX485fj5DEUiJZfJfkdWN/e9qPKI9OX5xK/w7Up1iModjC9J1divWBHUMElxYE2WKjwnEQkUsaJW0up5H4elZx06JK9FwR/9fTnLy/63Jr7kAyQdxV8t4GGKKsKR1LhmkKM2RRrHpUHzdXSB2UvqCzagupC2XfWthx7ctKNpyXz4byEexLMUdJOMmNQEXJG1xktG9AyZDml2d6c0T/vDCC9D9EZ48+GBNKLED0q5Aa6lXZqJG3O9zW7v6Y/m9ml1urUr89VjkcUTylTCY58uQBC+l7I2nKnCC+YxAtPPPfqZq14GUYsnzk6WO0GnUqs/RQNrxgGefO1mdHZozpT60/7kV5TMikk4iChacIGnKGONkC6DWu5V6w7X0mZsDRzYdX+UMVw6N1ak9bcpNeQ1iPnCfCEdoY3P9GJ3HsqSlV3l6n1K2pRRcC/N/l4jesnoxiGym1gzE4FeXP6JFYqVzNLm67ooRAdRe0Z4OQQlwNaiRLCuHNv9bfjKiTmPdeKMS+es28mJwv/tEfXgz1SYsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3231.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(396003)(39860400002)(136003)(86362001)(5660300002)(31696002)(2906002)(8936002)(7416002)(6506007)(38100700002)(44832011)(36756003)(26005)(6486002)(186003)(316002)(4326008)(8676002)(66476007)(66556008)(66946007)(2616005)(6916009)(41300700001)(478600001)(83380400001)(31686004)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFcyZldEWFhiY1NqL2F4QTVXTVFOT1l1M0RMUWtuMGVCVy94eW5sYXA2V3Yx?=
 =?utf-8?B?NzN6clg1SzJ5Vzh2dUt1UDNrTWJoaVkxbC9RNEhZb2xkNjBwL1ZZemdRQlZB?=
 =?utf-8?B?SnRuUFJCQnUrOE5CUnAvd1oyekN0THNIbG1oVUZjdTIwaVgrblZicWhWZmds?=
 =?utf-8?B?RzRpRVlXckh2dElDSE93bTNxdW1QR1gwaGFRWnZIbWh2T0x2TS9hMUl3KzFp?=
 =?utf-8?B?SmNNeGxabFZEV2VCcUNYdGtGT1MxQ1VEWnNNazFOM0NNbnZDM2hiVENDV3hZ?=
 =?utf-8?B?V0c5WDd2Qkd5V09oSXpIbEI0MSttMUVHc1ZXb1kzU1ducjdCV3ErdGV6UEZM?=
 =?utf-8?B?TFFvRHhva28yNEtBbnpBNG1XME8wdUZ2MU1QNzBNbUI2cFZXaWhrMmtqYzNY?=
 =?utf-8?B?WnljV0hVSGlIdEVzYW1RNmVDR2dGK1dsN21UYVlmb3JqM1JDSzJ2cEZCUCsr?=
 =?utf-8?B?VmF3WXUxSUNvQWY4UmorL3FzNmNHRXFsQytnc09rMFZqUXZZY0dDaXBpazNM?=
 =?utf-8?B?UEdrZWFiT01zWVl6ZzFmKzhOVFB5QTZYMytXWmhTREV2Mmp3ZlBJMHlneFpC?=
 =?utf-8?B?R2NhUGxaNy8rYmJRWHJsOFg4MEdOL1Qvdm9qa00wZktDNmtZZ1kxdWF2QUxN?=
 =?utf-8?B?YXVCd1d1VmxyVnIzMy9OaXZTT09aZW8reHhzVzRTTzNhUy9nNkdDS3lvU1pl?=
 =?utf-8?B?MjhoblBZRi82LzdhbHlBUkJZN01CVlh2MmR1YzNqRjZkV1ZUbFZEemxBV1Qv?=
 =?utf-8?B?UjFDNGkwSHBKbTZPUEYvaWR0M3RBVDBFSEJ6ZllBZXkwVnd6MTIrQ3c2a20w?=
 =?utf-8?B?RjhIUkdyK3FsaFczQlMxc3VaTXB4R1I2M2EvTDdCR3RNQ1VMRFdRTEM5NXRK?=
 =?utf-8?B?WUJMZGU3K0EzZGRDWjVFSktqU2hWYVd5ekNYMVRWdGdyV21SaVY0Si9BZnVX?=
 =?utf-8?B?Z0FBeXR3MHk5VzNhUk9pZXdRbzdwR1kyMTFxWFpZaFJSUFNRb3RDR3pkQjN1?=
 =?utf-8?B?LzlhNVlLTXQ2M29yZSs0RVpNczRJL1ExUFFEUmZnUXFMOVZWc1hSZ0VrTXhP?=
 =?utf-8?B?K1FSODZ2cVN5NDRXYXVXbU1JTnJwQWpPUm10UlpQNHhiN2JZSGtDcXovVXFu?=
 =?utf-8?B?M0hRU3BXSUdhNnlraDJGU2grRnR4VlFtSFliRDdCRUkraHRjUkFiZmUyYkFu?=
 =?utf-8?B?VkRXK0pjSWdGNk00WXZUa0ZQWlZWMzRoNEYyR3FqNkV3MStsVS85SnFSenls?=
 =?utf-8?B?cmQ5ZVRjTllPWWRMTVBOdmI5TVB5UlJRMFFpSXo0Y0d5OCtLV3BJUVlDa2ZI?=
 =?utf-8?B?N0RvWkx0WDRWZ1Y2UTRLZlI4MmFsOVg3NE04cjVIYTdEbm01L2JNZ0txaFBo?=
 =?utf-8?B?S0RUSllSU0ZkdThUZmRuOFhpZlUyZDZybmQyRmcwYkM0R0Z4dGlNcDdNWUVX?=
 =?utf-8?B?VmtiTTJKaTV2LytqWEE2bzJEY2VuaVpDdjNWUW9nTlZoVGx5akdwRWhWVHV0?=
 =?utf-8?B?dDBITzlxcEZnMkxmWTM3YUswWmF2WW1FcWUwSlR5MFdTVVNTUExyd0VWbzI2?=
 =?utf-8?B?endHako3TkpjRWp4ZFBRYUVPNGhPamhFdmxiNXFoNnNETGloSXM5a3dZaGpW?=
 =?utf-8?B?RXpYS1FNNURoZHF0cWt6MjZRZmRNY1dHaHdhRlZxcXYxeUx5cXh6Wi8xUGFw?=
 =?utf-8?B?a2lWcmczMHlYZmdXWXE2T0psR1hWVndpWGt6RHVUdkpXd1g3V1dKK25INThL?=
 =?utf-8?B?Y1JtbUwwZUhMMmZ0d1JQczhYNXhwbTZuTytxYzB0Snd2MjAwYm05cmdmRUl1?=
 =?utf-8?B?MWdDWUdpWGVJcWp2MkFRWjRGcldrUTI5NXdTNjR6ZVZHcS9hbHR3cktFcEdT?=
 =?utf-8?B?dTNsQ2diNTNIcmZIMTcxcHp0Z0F6L3RiNFU0WnRoYXFaMG5YV2FXbnIwQTRh?=
 =?utf-8?B?Y0cydzYxOG9IeFcxNnB4dy9mNTJpRjhCVjBPRkkrK3JYdUg4YWRURnhKZHZ2?=
 =?utf-8?B?aEtUZWEwWVVMZ2VzeUZxb0cyU2NTL0V1RGNLNjdCR0c0My9tWGVIbkZ2QlN4?=
 =?utf-8?B?R1BnY2F4WmZnalBEN3ZQMVhlU1pzdUJwTUh6UDd4RnIzbmNOSXY0SmEyR0Jp?=
 =?utf-8?Q?OrjZovESs0D1ezzhJTLhJaYIv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a0ef8e-b95c-44b4-ff0d-08da5bc0e177
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3231.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2022 00:22:00.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlqUhntdPOFUzwJ1Q70dfI+n9bf32trwfpMJGnfw4OsG0uoHo+1YaCEsL9MjKQw2rkdFWp9oQ2beRvjzf6MKPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1256
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-01_16:2022-06-28,2022-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=900 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207010097
X-Proofpoint-ORIG-GUID: E9ewm6ewQgjosepNgORjy82PQUhPqX20
X-Proofpoint-GUID: E9ewm6ewQgjosepNgORjy82PQUhPqX20
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/30/22 17:09, Al Viro wrote:
> On Wed, Jun 29, 2022 at 04:53:54PM -0600, Khalid Aziz wrote:
> 
>> +static int
>> +msharefs_open(struct inode *inode, struct file *file)
>> +{
>> +	return simple_open(inode, file);
>> +}
> 
> Again, whatever for? >
>> +static struct dentry
>> +*msharefs_alloc_dentry(struct dentry *parent, const char *name)
>> +{
>> +	struct dentry *d;
>> +	struct qstr q;
>> +	int err;
>> +
>> +	q.name = name;
>> +	q.len = strlen(name);
>> +
>> +	err = msharefs_d_hash(parent, &q);
>> +	if (err)
>> +		return ERR_PTR(err);
>> +
>> +	d = d_alloc(parent, &q);
>> +	if (d)
>> +		return d;
>> +
>> +	return ERR_PTR(-ENOMEM);
>> +}
> 
> And it's different from d_alloc_name() how, exactly?

By making minor changes to my other code, I was able to use all of the standard functions you pointed out. That 
simplified my patch quite a bit. Thank you!

> 
>> +		case S_IFLNK:
>> +			inode->i_op = &page_symlink_inode_operations;
>> +			break;
> 
> Really?  You've got symlinks here?

I intended to support symlinks on msharefs but I am not sure if I see a use case at this time. I can drop support for 
symlinks and add it in future if there is a use case.

> 
>> +		default:
>> +			discard_new_inode(inode);
>> +			inode = NULL;
> 
> That's an odd way to spell BUG()...

I think what you are saying is this default case represents a bug and I should report it as such. Is that right, or 
should I not have a default case at all (which is what I am seeing in some of the other places)?

> 
>> +static int
>> +msharefs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
>> +		struct dentry *dentry, umode_t mode, dev_t dev)
>> +{
>> +	struct inode *inode;
>> +	int err = 0;
>> +
>> +	inode = msharefs_get_inode(dir->i_sb, dir, mode);
>> +	if (IS_ERR(inode))
>> +		return PTR_ERR(inode);
>> +
>> +	d_instantiate(dentry, inode);
>> +	dget(dentry);
>> +	dir->i_mtime = dir->i_ctime = current_time(dir);
>> +
>> +	return err;
>> +}
> 
> BTW, what's the point of having device nodes on that thing?

There will be no device nodes on msharefs. Are you referring to the dev_t parameter in msharefs_mknod() declaration? If 
so, I am following the prototype declaration for that function from fs.h:

         int (*mknod) (struct user_namespace *, struct inode *,struct dentry *,
                       umode_t,dev_t);

If I am misunderstanding, please correct me.

> 
>> +static int
>> +msharefs_create(struct user_namespace *mnt_userns, struct inode *dir,
>> +		struct dentry *dentry, umode_t mode, bool excl)
>> +{
>> +	return msharefs_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
>> +}
>> +
>> +static int
>> +msharefs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>> +		struct dentry *dentry, umode_t mode)
>> +{
>> +	int ret = msharefs_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
>> +
>> +	if (!ret)
>> +		inc_nlink(dir);
>> +	return ret;
>> +}
>> +
>> +static const struct inode_operations msharefs_file_inode_ops = {
>> +	.setattr	= simple_setattr,
>> +	.getattr	= simple_getattr,
>> +};
>> +static const struct inode_operations msharefs_dir_inode_ops = {
>> +	.create		= msharefs_create,
>> +	.lookup		= simple_lookup,
>> +	.link		= simple_link,
>> +	.unlink		= simple_unlink,
>> +	.mkdir		= msharefs_mkdir,
>> +	.rmdir		= simple_rmdir,
>> +	.mknod		= msharefs_mknod,
>> +	.rename		= simple_rename,
>> +};
>> +
>>   static void
>>   mshare_evict_inode(struct inode *inode)
>>   {
>> @@ -58,7 +175,7 @@ mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
>>   {
>>   	char s[80];
>>   
>> -	sprintf(s, "%ld", PGDIR_SIZE);
>> +	sprintf(s, "%ld\n", PGDIR_SIZE);
>>   	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
>>   }
>>   
>> @@ -72,6 +189,38 @@ static const struct super_operations mshare_s_ops = {
>>   	.evict_inode = mshare_evict_inode,
>>   };
>>   
>> +static int
>> +prepopulate_files(struct super_block *s, struct inode *dir,
>> +			struct dentry *root, const struct tree_descr *files)
>> +{
>> +	int i;
>> +	struct inode *inode;
>> +	struct dentry *dentry;
>> +
>> +	for (i = 0; !files->name || files->name[0]; i++, files++) {
>> +		if (!files->name)
>> +			continue;
>> +
>> +		dentry = msharefs_alloc_dentry(root, files->name);
>> +		if (!dentry)
>> +			return -ENOMEM;
>> +
>> +		inode = msharefs_get_inode(s, dir, S_IFREG | files->mode);
>> +		if (!inode) {
>> +			dput(dentry);
>> +			return -ENOMEM;
>> +		}
>> +		inode->i_mode = S_IFREG | files->mode;
>> +		inode->i_atime = inode->i_mtime = inode->i_ctime
>> +			= current_time(inode);
>> +		inode->i_fop = files->ops;
>> +		inode->i_ino = i;
>> +		d_add(dentry, inode);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Looks remarkably similar to something I've seen somewhere... fs/libfs.c,
> if I'm not mistaken...
> 
> Sarcasm aside, what's wrong with using simple_fill_super()?
I started out using simple_fill_super() in patch 1. I found that when I use simple_fill_super(), I end up with a 
filesystem that userspace can not create a file in. I looked at other code like shmfs and efivarfs and wrote similar 
code which got me a writable filesystem. I might be missing something basic and if there is a way to use 
simple_fill_super() and be able to support file creation from userspace, I would much rather use simple_fill_super().

Thanks,
Khalid
