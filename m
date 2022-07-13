Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD93573C46
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 19:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiGMR7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 13:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMR7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:59:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CA013F89;
        Wed, 13 Jul 2022 10:59:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DFj3jZ011678;
        Wed, 13 Jul 2022 17:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=WTNM2Y71uH9YkmnI4mHkdgPbRXPl1KZ4R5WR4o8bZms=;
 b=DGqPLwi8plihiaC9wjqz1jdK4vocQj/FeBkawYmBfBtPVt9IOHYvNZI42MiBEcJhQSU8
 RmQeCEVNrGxD5Cox3y1TivrRSWRAi+R4pLbBR6vysnIYmilEASRDj1M6tLRuteMREbcY
 ngXF1u6kNpOiKAHzJvMLGWUC5gKDQbJCxpyKLs/IhaCRfApy9NoFfMXBV6Jehe4eOceW
 Lr/TdBf5s4NWDtELAoHBjdDz34EQTrt/tAQlnjSU4D6biLjRKZUDFQfXYv58CexZIBN6
 rEQL85DzqgOLWdXub3YYFMlc0L+nQN0hC6UK2vfkzkRZ6IDSGQ8Gyp9amTb3Hd7JP+U7 2w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1amjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 17:58:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DHeeU2012140;
        Wed, 13 Jul 2022 17:58:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7044m9ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 17:58:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMahaE4jvzS7mLKkEICd43Fr3q4xDRvH8fL1XhzOk8E4m84PiBhehYReiFmjUHDeKLb1jlmyw7NRmIGZgW7dFzZCUBR09DHJGPcLa+a/HJz3wwxav2glX+npnFD7Ry4t5cDaqSqhjslxB88koGaDtXCd88P5gTTxY+2n+pDqLy3IP0EQnKB2AS1wUrPPj6p84dqCa8gjUYAl5Rs/GbRzb77gXF07xynlRKUvjKysv1hLRJWZwfVWV4DAl35zT9/5g58iHftfkEQ12cW9LACHYchOokvIbwQdVnW4LkqgBt2WkmDrGyAHzakrzwdYk64oT8WRruE1+UTkQpka+A8Xxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTNM2Y71uH9YkmnI4mHkdgPbRXPl1KZ4R5WR4o8bZms=;
 b=Hg+3iA6u4ehxES7Bm0dRMoYH6lLZTY+PzutWUGP5maigq9OMtIE2Cy+VVSA2i2osftvG2rfNceAo/+huykKzk45G9dFgbwAVQJNlrPql9mTA5Gn2u8nqFEJiZ/3m9JFtoPDJV5rZpWuFzKjiuYlKTpPs1hQfk0idJXktHh/GItI3uaEHyahvu8qWomyJ9EwLnPnisW/Rhmlc64mMz8tNfUwKjBbaKyz8qazzF0o03lgCMVr07+UXu4r7p0erf+0jC8Bjz2VNcRTtwiDEga9UPvrYbygmu3yTBw8czJ4MM/PE2/6hBprUstcAkXsVkxsDF2H4dHwCdP/inBdhH5d0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTNM2Y71uH9YkmnI4mHkdgPbRXPl1KZ4R5WR4o8bZms=;
 b=OtVp5iNnZmRTAVGNXLCPBOeaENLrYLNtetyvx6TircAjf+PdLDDKS8XCnSNwU4KbBkjt/Pq+ONgYfdip89eJ28dx6RokG2u8AKfhrwJg0vRQIkm0jEBg1yvT+b2I6uYYoyra7bjpdZyJS4mmts+2mU5U7aFPXuhK7n4dB97HHrk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH0PR10MB5196.namprd10.prod.outlook.com (2603:10b6:610:c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 17:58:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 17:58:09 +0000
Date:   Wed, 13 Jul 2022 10:58:05 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, ebiederm@xmission.com,
        hagen@jauu.net, jack@suse.cz, keescook@chromium.org,
        kirill@shutemov.name, kucharsk@gmail.com, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, longpeng2@huawei.com, luto@kernel.org,
        markhemm@googlemail.com, pcc@google.com, rppt@kernel.org,
        sieberf@amazon.com, sjpark@amazon.de, surenb@google.com,
        tst@schoebel-theuer.de, yzaikin@google.com
Subject: Re: [PATCH v2 0/9] Add support for shared PTEs across processes
Message-ID: <Ys8HrW+52EwQbeh8@monkey>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <20220701212403.77ab8139b6e1aca87fae119e@linux-foundation.org>
 <0864a811-53c8-a87b-a32d-d6f4c7945caa@redhat.com>
 <357da99d-d096-a790-31d7-ee477e37c705@oracle.com>
 <397f3cb2-1351-afcf-cd87-e8f9fb482059@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <397f3cb2-1351-afcf-cd87-e8f9fb482059@redhat.com>
X-ClientProxiedBy: MW4PR04CA0248.namprd04.prod.outlook.com
 (2603:10b6:303:88::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5d0c6c9-58c0-49f9-0a84-08da64f93f02
X-MS-TrafficTypeDiagnostic: CH0PR10MB5196:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyzPm3UIhR/7PCnwxvwXOF5tKSxoDk3VkWDHO3AsSprNZWASizkZ9FAekthiAxwrImpt29sCof9ZtWdZwoNI8NIyJjJ1gXd3xDsGgAqexfiFickZLJeJMnu/z69HTyvHlrEOtX9HgddJASD+25pm4M261y4THbkRSYweLAc+SoEB8jqQ39fv3aTPWKV+0samV/MQiXqhRvOQxyOLLwYMd0EgA50TlLiaUuwhil2uoWqmg7uitki3AuX2//tlQBF+0f3PRl/scvy1b/vIv7JvoQa2zPZF6Eg7HVsWFJY/UTl5/CrUdvSXQh1FQ+ThMASBpoyl5pQbrjd+nGALqVfzzpoQgW5tHDsP2zbrDdo3vjsSdHQfZibECK5tqulCXDszW/Xd0gGg9Xv88JoP2ciaXM/qwu7B3gStFqye9P6FHrL6AG4H8Li8XsaX3fERr09ui5CzWAh5e3THWSNYLv0FI9ZrLF3TMZQT/9bG/sZ6Mo+S+mBN5qWhyeK0B/ZYzwZWCG1fS/Vq1WWFEljkqjEW+vkYtLT2JD7fCTdUTEvYeAjixRQDCSgPGNAaIZGQngBJ4+jsAjd/9MqZVH0V31je8TiseSZ/NhALHeIHS7P2wH82HqD+mwHOByfn7b7rYli6sdrrTyGaiHIERcj/lGGAND+TaPiyABzs1dLPxOy1MBpvPumXVgUnswZl3L8Dhwm+ZTDalE5an14sDbLB6gad8MjwKOlJ12Vci9mShN/r+uSDSP0SI+8r4zFPZ6OFAv271exKx9oiuZ2ThVjLq0PbqOOm5JQ3BmqbewrBTR7Ngnl/gQNQiY1WONtYYb5UdBbp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(136003)(396003)(346002)(39860400002)(53546011)(6506007)(2906002)(41300700001)(6916009)(6486002)(8936002)(6666004)(316002)(54906003)(66476007)(8676002)(66946007)(66556008)(5660300002)(4326008)(7416002)(44832011)(478600001)(86362001)(38100700002)(6512007)(83380400001)(186003)(26005)(33716001)(9686003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hv3MPyvlKJecu8/1MrqxMgM2l4/lrD5D3ml8NTn6PpqjnHMUisJB4dRjpCql?=
 =?us-ascii?Q?csQX+ETeYWBdYILvFsh58P60aIZfK+MRLlgiELCXVcJNEE8Ej/VxrhWZd0m9?=
 =?us-ascii?Q?8wiSBAepOPtyAcbjA6ukLVug0eNCZkJqCuuzCERUEWwwcTKsBsD8joas2zuA?=
 =?us-ascii?Q?g2p46ZDxQ/JpBc9AvgM9k14+NFdoBslbfIrqXpCU98tE9LIGj3hWGP9b19jD?=
 =?us-ascii?Q?sw97RZKeafdAgEnop0yF27eB5IlqqsgBGsrNhMkPIbWDAqobzNFXdG6TXLpM?=
 =?us-ascii?Q?15yc7Bontv+WdES0izG0nFY5FzdrSEWIHQfm97Pu4bnj3kdhOX+uKepJC7Vo?=
 =?us-ascii?Q?zfEKfzizTJVSlAKMeoi9Oh8/YBGUvRAq/gUXOmjsxwqJvwFXNpC0sI6eCCNy?=
 =?us-ascii?Q?R/E/Og6SI0ALv301QUzXHss3sZ/sbK66jTl5B07M0FTMgcDbbs+c2EUmtBux?=
 =?us-ascii?Q?9BloCIxoL1ASFt8ApfFK2Pk6RGiIGH3b2CPPcZq6koWTzKhZZfIBwNuVzkzD?=
 =?us-ascii?Q?GurszFUYyaxMzAKTrtry34lJ+vghZCtuP4bRd03N464mcXL0hjGO8YzIrNHt?=
 =?us-ascii?Q?kX2G0lvvwoq7wUGpZi+ANUIaoxotbd+B4ZRhxL3nTKTmCWNk45abh5bCNqGx?=
 =?us-ascii?Q?qkl7QCjxo4qR7K0X6ErjYopeTi+h7xQNkG3z3B1k6KLuOLe/Vqhc4bMIaXBN?=
 =?us-ascii?Q?nj4z0POlCTmSVefUfFfVz6R3Jkepy5B0iVxzkL8OKHAsefzFB0UVb/NaZ3PP?=
 =?us-ascii?Q?rCz+xEXbTrYd8MnxtUKSBnIwEWuNlXqK1kd5+NctVHKriaCdfIUX/lK3TI/t?=
 =?us-ascii?Q?RXCyE8tM8NwEyYkn3DKPg8LJdaJx53sY2cjlNZQQ4mcqcGS0V1Sx3jtpAR2e?=
 =?us-ascii?Q?7s7VidvkJSXxTIB9ylxGpNB1454tQ1JEdXZuSM0RYpcepaVoN3ToUUYWN6Fb?=
 =?us-ascii?Q?m6QvxaYBArcQim8YamH7klLClUqLox5t5520/bC/W9BXVTw6iH8BfTRCOMTy?=
 =?us-ascii?Q?kEqOei7Sfelv/u0AgnCqZ3zy8ynB7dXvHwr2lDnmeQDNT9qXeQ4ThC9vZvdi?=
 =?us-ascii?Q?3aDPre0HP1uO31JveUYZjZPtCc3J6ttEybpeRBemd1t9jMN+boM1I3DPvTkC?=
 =?us-ascii?Q?OS5rwbjg/JHTP1HXNg6svqDB2Ww/KTsboes+3qWqkWe8QFQkmpMjhEGHYZmE?=
 =?us-ascii?Q?/zLi/1sp1JF2ccd2HmJitl4uNyuZvjhqGYm3iuRnQvl9kqRzmHs3Dp9zFH/O?=
 =?us-ascii?Q?2/yMoCFwfOQHKetRCkHgC1Peq8jeeCqNa1Z6rCpiUE1asNHJQbNT1Hn0L+vC?=
 =?us-ascii?Q?skDA5Gtz4PZuXeG35LFbbvlgvnaruY/SW+xTcLr91o7UutJKYp9U9TU1xW//?=
 =?us-ascii?Q?hO0qrdmd2ZbsJH8Yr3XQjBg+N+EdxTMeH6s83oNondhPT21EneZvGG+q6DHe?=
 =?us-ascii?Q?dUrguoZhqdlYx0HsIJPl0UyX6pHG+u+T/vHJ8aAjPmPvjft9N4x4rVGcqKA/?=
 =?us-ascii?Q?QZsbj7xI3Oju2p+eRzBK0wAt30YaRQdbvlCXPnLlJIBNiFrC4FW9I/DT97ZO?=
 =?us-ascii?Q?Pd8FQhrTlD6jsd5hyoDLfYEDPSD+78m66/qjVnK4IkTk/DkHo/2kkY6ZZYlN?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d0c6c9-58c0-49f9-0a84-08da64f93f02
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 17:58:09.4640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uumXRnPh2R1jT8ihaqXCs1bOC6Zxc9CkxU+vjwzwLBTfCieaDLpOCPKjBObMApJ0jyuNG7sn20tE1BGlKnRCsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5196
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_07:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130073
X-Proofpoint-ORIG-GUID: _H_TIk3QMScriLrOmrCfGKfcVZTH_h7w
X-Proofpoint-GUID: _H_TIk3QMScriLrOmrCfGKfcVZTH_h7w
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/13/22 16:00, David Hildenbrand wrote:
> On 08.07.22 21:36, Khalid Aziz wrote:
> > On 7/8/22 05:47, David Hildenbrand wrote:
> >> On 02.07.22 06:24, Andrew Morton wrote:
> >>> On Wed, 29 Jun 2022 16:53:51 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:
> 
> > suggestion to extend hugetlb PMD sharing was discussed briefly. Conclusion from that discussion and earlier discussion 
> > on mailing list was hugetlb PMD sharing is built with special case code in too many places in the kernel and it is 
> > better to replace it with something more general purpose than build even more on it. Mike can correct me if I got that 
> > wrong.
> 
> Yes, I pushed for the removal of that yet-another-hugetlb-special-stuff,
> and asked the honest question if we can just remove it and replace it by
> something generic in the future. And as I learned, we most probably
> cannot rip that out without affecting existing user space. Even
> replacing it by mshare() would degrade existing user space.
> 
> So the natural thing to reduce page table consumption (again, what this
> cover letter talks about) for user space (semi- ?)automatically for
> MAP_SHARED files is to factor out what hugetlb has, and teach generic MM
> code to cache and reuse page tables (PTE and PMD tables should be
> sufficient) where suitable.
> 
> For reasonably aligned mappings and mapping sizes, it shouldn't be too
> hard (I know, locking ...), to cache and reuse page tables attached to
> files -- similar to what hugetlb does, just in a generic way. We might
> want a mechanism to enable/disable this for specific processes and/or
> VMAs, but these are minor details.
> 
> And that could come for free for existing user space, because page
> tables, and how they are handled, would just be an implementation detail.
> 
> 
> I'd be really interested into what the major roadblocks/downsides
> file-based page table sharing has. Because I am not convinced that a
> mechanism like mshare() -- that has to be explicitly implemented+used by
> user space -- is required for that.

Perhaps this is an 'opportunity' for me to write up in detail how
hugetlb pmd sharing works.  As you know, I have been struggling with
keeping that working AND safe AND performant.  Who knows, this may lead
to changes in the existing implementation.
-- 
Mike Kravetz
