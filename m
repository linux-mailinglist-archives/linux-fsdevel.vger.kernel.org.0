Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA65249E230
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 13:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbiA0MUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 07:20:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62116 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241033AbiA0MUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:20:48 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RBkEZb009133;
        Thu, 27 Jan 2022 12:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=fhkX3cuAqsg+3k/dr3+e9855wqIq6Aj6ohJUQGiCvfQ=;
 b=mCdueMqPnBH5R9k0cmk1u+7u1qIhxyaamnbVs8t2gSx0hFXuzD1m9xsBQIsUylpejpU4
 h0jLxgwIeB3lStuSg8C2quixuWlhE6QcqRQLqmJTIwqLPoTDG4lWvpCEqx4dEC4ei2TQ
 wKH4HOYzV/awJzAwbSoqVK5IDgpQY6KiZQAyT4uiDe9YY5SDGiI4TERWHu3TcXDgYN3s
 e/Ff0QjCmrk2k1xKLh9xMcHCkXTFS4fBQxCfI14uR0hYRQqpACQTQ38VGhPz9J6eNJ+g
 iKGUgVia1v4/xJYG7rX+z/3W8gYJaweycvubc/cnh0hBEe35md2T5IPIdocLEFTZWtKe dA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dutt8gs7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:20:46 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RCE19j022505;
        Thu, 27 Jan 2022 12:20:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3dr9j9nmu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 12:20:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RCKgiG47710588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 12:20:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3837142045;
        Thu, 27 Jan 2022 12:20:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B6B842047;
        Thu, 27 Jan 2022 12:20:41 +0000 (GMT)
Received: from localhost (unknown [9.43.13.79])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 12:20:41 +0000 (GMT)
Date:   Thu, 27 Jan 2022 17:50:39 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Maxim Blinov <maxim.blinov@embecosm.com>
Cc:     linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Help! How to delete an 8094-byte PATH?
Message-ID: <20220127122039.45kxmnm3s7kflo6h@riteshh-domain>
References: <d4a67b38-3026-59be-06a8-3a9a5f908eb4@embecosm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4a67b38-3026-59be-06a8-3a9a5f908eb4@embecosm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4awuAqW7Ym2xPMW5fqdoDFU-2vhpOvu-
X-Proofpoint-ORIG-GUID: 4awuAqW7Ym2xPMW5fqdoDFU-2vhpOvu-
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cc'ing linux-fsdevel too.

On 22/01/27 07:06AM, Maxim Blinov wrote:
> Hi all,
>
> I'm not a subscriber to this list (so please put me in the CC), but I've
> hit a really annoying un-googleable issue that I don't know who to ask
> about.
>
> A runaway script has been recursively creating sub-directories under
> sub-directories until it hit the (apparent) OS limit. The path in
> question goes something like this:
>
> /work/build-native/binutils-gdb/gnulib/confdir3/confdir3/confdir3/confdir3/confdir3/........
> (you get the idea)
>
> It was only stopped by the following error:
> mkdir: cannot create directory 'confdir3': File name too long
>
> OK, fine, that was silly but whatever, right? I tried to delete this
> huge directory from the top with

;)

>
> rm -rf confdir3/
>
> but that simply generated the same error as above. So, I figured "Hey,

Strange. Though I didn't try creating same name subdirectories like how you have
done above i.e. confdir3 within confdir3 and recurse.
But I was able to remove the parent directory after hitting the max PATH_LEN
issue.

I ran this test below test to see if it fails on my ext4 latest tree. But this
passes. https://github.com/pjd/pjdfstest/blob/master/tests/mkdir/03.t

But just curious, by any chance did below fixes it for you?
echo 3 > /proc/sys/vm/drop_caches


-ritesh

> I'll just walk all the way to the bottom, and delete the directories
> one-by-one bottom up". Here's the script I ran to get to the bottom:
>
> $ for i in $(seq 999999); do echo "im $i levels deep"; cd confdir3; done;
>
> It then ran for a while, and eventually I got to the bottom:
>
> ```
> ...
> im 892 levels deep
> im 893 levels deep
> im 894 levels deep
> im 895 levels deep
> im 896 levels deep
> bash: cd: confdir3: File name too long
> $ ls
> <nothing here>
> ```
>
> So then, I `cd ../`, and `rmdir confdir3`, but even here, I get
>
> rmdir: failed to remove 'confdir3/': File name too long
>
> I would be very grateful if someone could please help suggest how I
> might get this infernal tower of directories off of my precious ext4
> partition.
>
> I was thinking maybe there's some kind of magic "forget this directory
> inode ever existed" command, but I am out of my depth with filesystems.
>
> Best Regards,
>
> Maxim Blinov
