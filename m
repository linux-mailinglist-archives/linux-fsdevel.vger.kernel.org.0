Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3D15CE16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 23:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBMWdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 17:33:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46214 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgBMWdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:33:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DMWc6H152983;
        Thu, 13 Feb 2020 22:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : subject :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=NpjRCzo2rTzOe6HlOeVL9C/0xrjNS70JovCKzVWJyq0=;
 b=JOiMFR202QcuvnkGB0LI7wqPmJyOzy1cavZz2aE7epm5ZZGzKLnJLQHipLUeWnxHBNXY
 2erB1gPLr2S3DRivQuVHHg6zAbT+AuHsoOEFAOLmqxnU7LWxeb/u3Saqw3dDYysYbLZ6
 7Gn3W8djCqRC/3uUmjQXc64w2j+6mh5YLajFonjhDkIRPobBMnqOctvD3VcWs6agxirQ
 lawgdAztqwjZfc5+I/uBZvAL86MAFuONSXcoO8Ue2+rTkJdort5OXzHXbr9R0Q8N3q9N
 tvmQpLJ6aWUhefqnVL2mJi53IhcGtbXag1hyZhMEILpoTRC33EJMf8KAoyw89Y5MHZbh 1Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y2k88np70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 22:33:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DMRwR0061667;
        Thu, 13 Feb 2020 22:33:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2y4k38nsqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 22:33:10 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01DMX9vD015102;
        Thu, 13 Feb 2020 22:33:09 GMT
Received: from [192.168.1.223] (/67.1.3.112)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Feb 2020 14:33:09 -0800
To:     lsf-pc@lists.linux-foundation.org
From:   Allison Collins <allison.henderson@oracle.com>
Subject: [Lsf-pc] [LSF/MM/BPF TOPIC] Atomic Writes
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <e88c2f96-fdbb-efb5-d7e2-94bfefbe8bfa@oracle.com>
Date:   Thu, 13 Feb 2020 15:33:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=979 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=1 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=1 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130160
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I know there's a lot of discussion on the list right now, but I'd like 
to get this out before too much time gets away.  I would like to propose 
the topic of atomic writes.  I realize the topic has been discussed 
before, but I have not found much activity for it recently so perhaps we 
can revisit it.  We do have a customer who may have an interest, so I 
would like to discuss the current state of things, and how we can move 
forward.  If efforts are in progress, and if not, what have we learned 
from the attempt.

I also understand there are multiple ways to solve this problem that 
people may have opinions on.  I've noticed some older patch sets trying 
to use a flag to control when dirty pages are flushed, though I think 
our customer would like to see a hardware solution via NVMe devices.  So 
I would like to see if others have similar interests as well and what 
their thoughts may be.  Thanks everyone!

Allison
