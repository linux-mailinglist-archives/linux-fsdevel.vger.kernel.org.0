Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89358560775
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 19:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiF2RjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 13:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiF2RjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:39:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3861A83B;
        Wed, 29 Jun 2022 10:39:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TFE9LS029496;
        Wed, 29 Jun 2022 17:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4xN+ilVnSmObPBznhV5a1re7NHsrn8ClX4QuO8KKKBY=;
 b=WHs8g19IRL7jmirpHEX6FmZ5H2RyEALX2GDl5L8qt41SPv0hRh0CphUVqDFUjB2aLXN3
 /F8I0pcA7s9h2GK+qAxLTzAnlw/IccMCsteXElNUsCYZhmfkUr7637/paFmrvyc6iyOZ
 ayn1Ifwd0+q9GMYExi8hnfKpz5HZ1N98YYSzzgDAQ2fQLmBN44j14AIZk5cFeRMi5k7Z
 Piw1xhRBfv7JGtveVdii7hzu6zHIGeLO2SAo/8nwp+d2aa8Uz022eL2z58rI/HKBfzmO
 kuqCeg1JcTnyAmp59pgJmw41AG2hlIhfmmDLWOOdHEMSQdJTOkh8QaQlJqK0NOrfHB85 +w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrschu36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 17:38:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25THUPKb027813;
        Wed, 29 Jun 2022 17:38:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt3b5a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 17:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRQ0jdLyVTbtsU8LjmLf1Ttd4qy8mcJA95QNxZ0mtfjpSHxLmGPiA3W+RBGnruiL+feG2rAvUF+2A7d2e79porryLYz4FE1SbYSF9LW1zFYfV607Tfi9v9bO34GuRgFnVXTtDI4xLeX/pHwjwUQv/Q4tD0IFNn5d/URDL1UzopCpFDWrsZffnbRszY3tII3aKSVC5uYkZDTLHa2gigxd/TRqnqJK3uYR148leUXPkyRVou+wnwNDBYQ0/8kbvJhGI2bHo8V84awmNOGz68R0qh5QYXjT/RJEGI1/UdfYuCoSu0otU/VsTJsz5r2J9x58kfhmS6dpM/aa4cesZW/iJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xN+ilVnSmObPBznhV5a1re7NHsrn8ClX4QuO8KKKBY=;
 b=Zhi5mCw5q0OGU3Y8cMZEP24OX4xmXG9HFVx08aWiyogSqerKWqn5Wwzv+lwc3vSqCkya0GIHf9ehRVJuLmhqL4UeVBB2WWBao/Hi5EzwQKiptCX3GLlfQINYNpyq+i1eswlwRJeouMlLNz2QJknhPW+DzkUcVh+kvsUrp1XWT5PJIkiCL0+yfI7gEP2ZnXlkCWiY5oh5suUwNW1nRcfHilqqtuW2rImYsTuHMJ0jZkhEsaxqZhJZ2pE1QfI8uiM0o9Vh5DhJzyFNtaYqGfrNARHyawkJy0OEoZjb2gANYiMyOAXpytA055gzO+jlaik7gVicW9FYUE9moYNWn9s6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xN+ilVnSmObPBznhV5a1re7NHsrn8ClX4QuO8KKKBY=;
 b=amhonHRtiPq4ppniqi0OOmJ/jDfIvBi+JFr96J6BVjyF6dTQ7aYmzFYWpET89NL64Phct8WTKL6LUayexvdepF20KrUdQ4MEwZ7C1VGCZvas+IYzjUlUJZksZWi6DA8/1lu4+YhAnU+aFa8q+uIMOqJ3H+qfdJoUdtQ/LBQ7go8=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CY4PR10MB1829.namprd10.prod.outlook.com (2603:10b6:903:11a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 17:38:31 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 17:38:31 +0000
Message-ID: <e5bebb34-5858-815c-9c2c-254a95b86b07@oracle.com>
Date:   Wed, 29 Jun 2022 11:38:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 09/14] mm/mshare: Do not free PTEs for mshare'd PTEs
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, ebiederm@xmission.com,
        hagen@jauu.net, jack@suse.cz, Kees Cook <keescook@chromium.org>,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, longpeng2@huawei.com,
        Andy Lutomirski <luto@kernel.org>, markhemm@googlemail.com,
        Peter Collingbourne <pcc@google.com>,
        Mike Rapoport <rppt@kernel.org>, sieberf@amazon.com,
        sjpark@amazon.de, Suren Baghdasaryan <surenb@google.com>,
        tst@schoebel-theuer.de, Iurii Zaikin <yzaikin@google.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <f96de8e7757aabc8e38af8aacbce4c144133d42d.1649370874.git.khalid.aziz@oracle.com>
 <CAGsJ_4xC0sB0x2orOcKgx4p0fa5Y0bR9qeviq1_Q7VmhMk2d6A@mail.gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <CAGsJ_4xC0sB0x2orOcKgx4p0fa5Y0bR9qeviq1_Q7VmhMk2d6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::47) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7c31472-bc8f-4a0c-faa1-08da59f62ec5
X-MS-TrafficTypeDiagnostic: CY4PR10MB1829:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHwt7g7meYpZrY3IEtuYAEZiralBkzTZ2321fY7/DW7k9Rd5aHT1+kb6xxGxREizaM2iAIUiUl4MsjfI4oeO8wW15kwKwMQf0Bi9L64v7xwBBWYm5eB4QwQb04z6tEY18biH1L8dM2XL5qIpFZhBxs6Zb2dGUAymwjAEkoqpNlLO/vBw20kiua5wq7FxXHkFIpfy329gj0q2VcWmSxgS9O5R5UdIJhhbkT878niiadxrNn90MG2MgDy8DXc0nOLYqt0q/JbMtr5burKGEci9s339NgyXis5GQgyaIxcYOYmqxULZWvJMso6vE1q6l2KQ7msm7cEmqyF91WkdR5J3bNteMfhbG5UMHwoWrsZf8Gv1Lut4JvMS7H1tdGxYnhYQ75R+skJ+TEUFyV8Boh7sO0QygDEqNBUThFGBrwQxrJRFXWp2GXgaGMjKkFM58viM9TB+llGUGG0nSK/DxBrMgIbaF6A7ZHsRVXb/g6rVTn47d3D12ZrzMFk77csLES6bCnegnJBoWoyxwxqdPgtSZHZXs01x1kLEtnPuTE1dSY5q6O04gIDNyNE+Yt/Jb9v6OFEMUjZ7Mfk+MnarcZau75meJ5NeDc0xRmppWM/tFkwZu+IqGJ7xvM3zSE9o2cNaCY788F2XvJL14tjux5tLMgyr4JjFnpEmaQnN2kOMQYnfyy3x+ZujR7z+OIjuTQUbRZb8MeWbQTiEuMVNmFgBbgDn68cRwf1/f6CoN4ZpY7cvw+jeTKPTA9H9aTPmoFLxFMVa3PJ8dheOMBp6DfdMesNylWMAlfyCu/dGJR+weTLa3e0DTsOFbU/K7n06LjzF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(136003)(376002)(366004)(5660300002)(83380400001)(36756003)(7416002)(44832011)(6916009)(54906003)(186003)(31686004)(2906002)(41300700001)(478600001)(8676002)(6512007)(8936002)(86362001)(53546011)(66946007)(316002)(6666004)(2616005)(6506007)(6486002)(31696002)(38100700002)(66476007)(4326008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1NTUUdFdWd1T21OWktPa1E2aGJJRmJOeEVEM25aOVFORDZxTEE2ZjhjbGhG?=
 =?utf-8?B?ZE1NRXJETDEwWlZmMzJwRGxPZGJyUGtzempQRVpWR0ltOFQzWFFTNjJoRlU4?=
 =?utf-8?B?cmhobjJwcWNvNFBEOHpDTTJrZk1nWmJBSjBUdEtjeXlIdzlNNndzT2pEUWFQ?=
 =?utf-8?B?alc5UWJjZWtoK2JHZVhHcmpZRmdtZS9GanFZK1FnbDIyRXNzZCszRUhldTFl?=
 =?utf-8?B?b3FGS1dIbE5rcVYxZnN0ZlNnSWZXVkpPM1cySHVwWXhEVUlEZjJ4eEN2dHNF?=
 =?utf-8?B?cFNEWno0QVhuOU02d0kvYUFqaHRVeTZZY05YcnJQLzZuR2FzNHpQOVNsNWph?=
 =?utf-8?B?ZTFiY09yaDFYODNmNnJtRGVMQng3T3hJa0NZcmdDR1BIN0tJV1RKNlJGa24y?=
 =?utf-8?B?Wit5RzhLVXdpMUJaT3VDRjhxUVJIcy95cFZTYStxU2dzS0hYeWlKNHh4S1ds?=
 =?utf-8?B?RnJNblJwbFFWT1BzaWJCTGhvWFJXV0J1ajhhNDkxMUdrUy9pU2JzWlVHVGhv?=
 =?utf-8?B?YjQyeXlZNFRDeUdWZDdCNEJVM1U2aWZRMWVuY1JYVW1jYWlMcDFzKzB1YU5K?=
 =?utf-8?B?ZEZNcE5VRWwxbEtiRmVMemp2N0RmbEhOU29TSFRCendnZmtnNzExV2psVVV2?=
 =?utf-8?B?UmN4NittcFVYOVliZHZKYjg5THEwZHhMdDF3SThVNzJCV0hMc0hwMnpodWw1?=
 =?utf-8?B?eGlzclBCZlVyV1czMWNuZWZ3ZTdLVlVaci9xbEVLSGxPZVJxN05SUytIcjd3?=
 =?utf-8?B?aVlTeVBvNmlYaFk0UllYSS9xS3ZxMlZVSWs2blcreXRJVmgyL3BPby9hM2Zm?=
 =?utf-8?B?VHhQTGVtVzNBWTA4bFNwQ1duMHBYWXpJOG5PNitqc0JoZzJsSE5iUi9INlhv?=
 =?utf-8?B?bUp1N3ZsOFVvM002bUU2M3hQRUxTVnozQTY5RmZRRllSL3I4OHp6cTc5Tzc4?=
 =?utf-8?B?T0pRZUtvRDZpL3R2UWJvU1lZNFd6SGVqTmczc1lwc0FjYXVMMTVxd0ZNTnJG?=
 =?utf-8?B?TS8zREl3L2lqZGlJaitmcWJETVVoYmVIODdVRFR0cDNnOTltYmhmRmZ6NGx6?=
 =?utf-8?B?MmNOR2syN3NBTlNickVERWRmQjAvWk9UVS9FeHAvKy9rMzhRTDliaUV4TkVK?=
 =?utf-8?B?WmNMUFhqRVVZQTZiSGVxQWlwMUI3a2hmMm1OUlFFbktQcGFoZTdnYUNlZEs4?=
 =?utf-8?B?UW95eWZySkUwTUlFYk1MNkR3L3hxUFM3aVhXeXQ0YnpxUHlDNjhRYVdzdlRG?=
 =?utf-8?B?M2ZzWlA1UXJKb0RKSjdyRGNNYkJSMC9sR2U1Z1BjL29ZeDBTYUhQSUl1VzRi?=
 =?utf-8?B?Z1E5ZTN2cGlCdUl6NktKZThxOTlpU0ZUVFZ3a0xMWk55OTFsSmVpdG1QSnRs?=
 =?utf-8?B?eDFXYXhORnhjdDBrODIwYzl2U0hKNkVDQ1Z3NW5BR1E0elBHaXgrWmY2L2dx?=
 =?utf-8?B?WHYwcC85V3B2Sy9qbUlUUHhZcnVOOUQ1emoxMTQ1L2x1WWhmaGU5Slp4TGw0?=
 =?utf-8?B?NTExdytCeFlBekV1dW0zQmRvS2RJOU1Uc2c4VnJuUXFvbnFRU0JaRllNV2pV?=
 =?utf-8?B?OGt4QnlHc0ovK1RHZDA4QXFZamp0RWlGby9pZEQxaHRoUUtRdGxmTVp6QWVO?=
 =?utf-8?B?Ym43WVYzRDRTREsyQXp2S3VSWExsT0hoZ1RIU21kTnl5RlB1YUlrZnhtM21D?=
 =?utf-8?B?d3piR3BIUHpvYmw2N1NjbTZjNEJTdFlrNStaNGFLNHdxWHAyOS92dFpoS3d6?=
 =?utf-8?B?T3RUQnJpS1JxSmlDVHpVamtGSEcybFVkU0duZFhERzd1K2FUcGtCNHcxUEVS?=
 =?utf-8?B?RlhpQXRSb3VZbEZxejg2Z0VxWGZIeWVrRmdqM2V4dFNHL29ocUhNODJPQW9s?=
 =?utf-8?B?N3E1TVg4R0x3U1VGNXpkN0cyN1dBZ00rSzA3eGczZFNqOWZzM3dNRGVFeCt0?=
 =?utf-8?B?Si9rV3BRMHpZWnF1Vmw0NnNQNVFyc0VEWEl6ZWhSeXI1eitXTTVBVkVQTm1a?=
 =?utf-8?B?OFBpOFZXeVNjR1c3TUVETzRYLzBoRGhHR2ZRcmN6NHhySDYveGVJZjUrcW00?=
 =?utf-8?B?aENHOVIwOENWckV0eEFmMGp6NjRUb2RUbUE1SHYyMTJCOUxVUWdQdnpXeUc4?=
 =?utf-8?B?SEJDRVBRcDY2V3VpVWF2dS91WGdPRlBDeURHTVUxa2k2SWo0cXV1clZDL3B2?=
 =?utf-8?Q?HzildDK5P+E4qJYRY/hMy6veGIPDLaBdD8naQ/n4JTc6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c31472-bc8f-4a0c-faa1-08da59f62ec5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 17:38:30.9618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLOg0k/or37NKZO/A3rTE5exQHgDedoPR2cm+oJXTdnn01VyeM5mSX4RHgV0kaEPZyLKdMcLAr+jLvl1AaXxxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1829
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_18:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290063
X-Proofpoint-ORIG-GUID: _D-0JYRaNnKTtj74YagXgISdoApgHLvB
X-Proofpoint-GUID: _D-0JYRaNnKTtj74YagXgISdoApgHLvB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/30/22 22:24, Barry Song wrote:
> On Tue, Apr 12, 2022 at 4:07 AM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>
>> mshare'd PTEs should not be removed when a task exits. These PTEs
>> are removed when the last task sharing the PTEs exits. Add a check
>> for shared PTEs and skip them.
>>
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> ---
>>   mm/memory.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index c77c0d643ea8..e7c5bc6f8836 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -419,16 +419,25 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>                  } else {
>>                          /*
>>                           * Optimization: gather nearby vmas into one call down
>> +                        * as long as they all belong to the same mm (that
>> +                        * may not be the case if a vma is part of mshare'd
>> +                        * range
>>                           */
>>                          while (next && next->vm_start <= vma->vm_end + PMD_SIZE
>> -                              && !is_vm_hugetlb_page(next)) {
>> +                              && !is_vm_hugetlb_page(next)
>> +                              && vma->vm_mm == tlb->mm) {
>>                                  vma = next;
>>                                  next = vma->vm_next;
>>                                  unlink_anon_vmas(vma);
>>                                  unlink_file_vma(vma);
>>                          }
>> -                       free_pgd_range(tlb, addr, vma->vm_end,
>> -                               floor, next ? next->vm_start : ceiling);
>> +                       /*
>> +                        * Free pgd only if pgd is not allocated for an
>> +                        * mshare'd range
>> +                        */
>> +                       if (vma->vm_mm == tlb->mm)
>> +                               free_pgd_range(tlb, addr, vma->vm_end,
>> +                                       floor, next ? next->vm_start : ceiling);
>>                  }
>>                  vma = next;
>>          }
>> @@ -1551,6 +1560,13 @@ void unmap_page_range(struct mmu_gather *tlb,
>>          pgd_t *pgd;
>>          unsigned long next;
>>
>> +       /*
>> +        * If this is an mshare'd page, do not unmap it since it might
>> +        * still be in use.
>> +        */
>> +       if (vma->vm_mm != tlb->mm)
>> +               return;
>> +
> 
> expect unmap, have you ever tested reverse mapping in vmscan, especially
> folio_referenced()? are all vmas in those processes sharing page table still
> in the rmap of the shared page?
> without shared PTE, if 1000 processes share one page, we are reading 1000
> PTEs, with it, are we reading just one? or are we reading the same PTE
> 1000 times? Have you tested it?
> 

We are treating mshared region same as threads sharing address space. There is one PTE that is being used by all 
processes and the VMA maintained in the separate mshare mm struct that also holds the shared PTE is the one that gets 
added to rmap. This is a different model with mshare in that it adds an mm struct that is separate from the mm structs 
of the processes that refer to the vma and pte in mshare mm struct. Do you see issues with rmap in this model?

Thanks,
Khalid

