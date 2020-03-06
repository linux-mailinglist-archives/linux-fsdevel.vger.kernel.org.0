Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7417617C632
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 20:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCFTVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 14:21:08 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55312 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgCFTVH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:21:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026J3uWH049450;
        Fri, 6 Mar 2020 19:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=3DsRlM5HeQgYOkX3HErteET4VDOsu5ozhvfvH//y2EY=;
 b=QUywfwVow9wBNj9q9QjqCgrqI/y4LNRvPwN31Ti03fsENhwk3/2dJVPPTHYkpBFK1/kX
 9oUYHfMMk2vW8TSa5DBIBittZFH7O/IKJ3hEOFT/tb9AWGJTzQEfTBHBNXAitXnhd7ut
 JIztcJ4GbzT94fYGkRHoBiEcpuodQ8mYUReA8dt7/6KytiQw5oytw7JgG6RZibZBYc3Z
 vIZqe/ogFb3iKEn3EUD7icLxe6BkBax6ko2w9Hnr7HaIrZGDkuw8HazQm4A6FILnBTM5
 ulIKQlXMpDExRjcaW3m/MerkFkVjIbkUgx4p0R+k+sdXIielfjf0WHBEQwKlK2upVzZu /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ykgys3qjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 19:20:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026JD3RH069608;
        Fri, 6 Mar 2020 19:20:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2yjuf4bud4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 19:20:55 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 026JKrAg001268;
        Fri, 6 Mar 2020 19:20:54 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Mar 2020 11:20:53 -0800
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
        <20200306160548.GB25710@bombadil.infradead.org>
        <1583516279.3653.71.camel@HansenPartnership.com>
        <20200306180618.GN31668@ziepe.ca> <yq1eeu51ev0.fsf@oracle.com>
        <1583522151.3653.81.camel@HansenPartnership.com>
Date:   Fri, 06 Mar 2020 14:20:50 -0500
In-Reply-To: <1583522151.3653.81.camel@HansenPartnership.com> (James
        Bottomley's message of "Fri, 06 Mar 2020 11:15:51 -0800")
Message-ID: <yq1wo7xz3vx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=866 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003060117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=925 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003060117
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


James,

> To be a bit mercenary (hey, it's my job, I'm Plumbers treasurer this
> year) our sponsors are mostly the same companies.  If we combine
> LSF/MM and Plumbers, I can't see too many of them stepping up to
> sponsor us twice, so we'll have a net loss of sponsor funding for the
> combined event as well.  This is likely another argument for doing two
> separately sponsored events.

Yep. And I do think it's beneficial to have two developer-focused events
per year.

-- 
Martin K. Petersen	Oracle Linux Engineering
