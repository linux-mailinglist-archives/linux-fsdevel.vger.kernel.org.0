Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCCE5F4CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 01:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJDXeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 19:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJDXeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:34:07 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC005F9AA;
        Tue,  4 Oct 2022 16:34:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b20so1696636iof.2;
        Tue, 04 Oct 2022 16:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:from:to:cc:subject:date;
        bh=s5HrryHJPB7lovuznIyWrkMVPQe/bG6KzW2zp+PFH6w=;
        b=afpnIG8FhVvpqxfxHVtx9TEpu4pjvU63u60l2O/ic+ATjuYm47tz9FuEYiLKgou/K5
         C9hPc+Tz1B/jV06aysYiMfki+z6Szhc23gHIMdQfc0H9MXZMUJGsaHMrCBM+5y+Cfs5b
         IePz1BKlza/7r+oxvEaWJTmr0pCz7HEPnzvoyOa2xifSxkQdBMTCMEKKon40KiQGtxq4
         wXYuZfzuYOn+jNt4/X1xxKIZFGV3LNrnyPNLvM4PrTn2C11Nc3NA+QFPEsAzVY1EcgW5
         mRiJ4dnXrKJTwcrA/0iz+kF/zTS0CocjEXyvgR7oU8oJKsPNkHo6z0bTcOjreUy26SJm
         gI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=s5HrryHJPB7lovuznIyWrkMVPQe/bG6KzW2zp+PFH6w=;
        b=oS5LpBYc8o75RpAlQQtvYJM8JtVfd+sAE5hpRAzIE59nLt4zOeGqrJWeHrqkZ4n9Uw
         /PscA/Lsqg/Xy+iX0myTdY3AvQa7EFXz+97UjhJbdHSAeYIT614kQ1ofH4b4ZrNI7iK+
         Gp1lYzvdfvW6FVNyQb0GwPlob3vAn8n82BfLVg084PUVlB9h/hgPEJsIuN5ZxbumkkXC
         P0FQS4IsrQRdBOcOvnHRsPi+W78kumyC5tGEw9eAgRs29rp6I2vCF1fQUH0kTW67wvDx
         q+rRMjEVoVqGM6ATVdvgKtZUAk/fdctvtmLIpiaNA2XtZSWDcJPyWRfYh+MgAmua58q0
         ZsWQ==
X-Gm-Message-State: ACrzQf3C1QPKGFY6QNOhiDWk0TXRTFMp6bhf0qyV0NhLseW9E0bdPHMy
        7fzJE64/SJXmrai1cldFCXcDikC4E9c=
X-Google-Smtp-Source: AMsMyM6jY1itX8Uik5IEpT6QQkELlhkvFXPHGNu3ajJOiqnoMQPaH30f2M9zgs5FUkkJp2g1f3bqlw==
X-Received: by 2002:a05:6638:379e:b0:35a:6503:453c with SMTP id w30-20020a056638379e00b0035a6503453cmr14250389jal.118.1664926445499;
        Tue, 04 Oct 2022 16:34:05 -0700 (PDT)
Received: from [172.16.0.69] (198-0-247-150-static.hfc.comcastbusiness.net. [198.0.247.150])
        by smtp.gmail.com with ESMTPSA id b26-20020a02a59a000000b0034c10bd52f5sm5802233jam.125.2022.10.04.16.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 16:34:04 -0700 (PDT)
Sender: Frank Sorenson <frank.sorenson@gmail.com>
From:   Frank Sorenson <frank@tuxrocks.com>
X-Google-Original-From: Frank Sorenson <sorenson@redhat.com>
Message-ID: <d00aff43-2bdc-0724-1996-4e58e061ecfd@redhat.com>
Date:   Tue, 4 Oct 2022 18:34:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] xfs: use iomap_valid method to detect stale cached
 iomaps
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220921082959.1411675-1-david@fromorbit.com>
 <20220921082959.1411675-3-david@fromorbit.com> <YyvaAY6UT1gKRF9U@magnolia>
 <20220923000403.GW3600936@dread.disaster.area> <YzPTg8jrDiNBU1N/@magnolia>
 <20220929014534.GE3600936@dread.disaster.area>
In-Reply-To: <20220929014534.GE3600936@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/28/22 20:45, Dave Chinner wrote:
> On Tue, Sep 27, 2022 at 09:54:27PM -0700, Darrick J. Wong wrote:

>> Btw, can you share the reproducer?

> Not sure. The current reproducer I have is 2500 lines of complex C
> code that was originally based on a reproducer the original reporter
> provided. It does lots of stuff that isn't directly related to
> reproducing the issue, and will be impossible to review and maintain
> as it stands in fstests.

Too true.  Fortunately, now that I understand the necessary conditions
and IO patterns, I managed to prune it all down to ~75 lines of bash
calling xfs_io.  See below.

Frank
--
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer
Global Support Services - filesystems
Red Hat

###########################################
#!/bin/bash
#	Frank Sorenson <sorenson@redhat.com>, 2022

num_files=8
num_writers=3

KiB=1024
MiB=$(( $KiB * $KiB ))
GiB=$(( $KiB * $KiB * $KiB ))

file_size=$(( 500 * $MiB ))
#file_size=$(( 1 * $GiB ))
write_size=$(( 1 * $MiB ))
start_offset=512

num_loops=$(( ($file_size - $start_offset + (($num_writers * $write_size) - 1)) / ($num_writers * $write_size) ))
total_size=$(( ($num_loops * $num_writers * $write_size) + $start_offset ))

cgroup_path=/sys/fs/cgroup/test_write_bug
mkdir -p $cgroup_path || { echo "unable to create cgroup" ; exit ; }

max_mem=$(( 40 * $MiB ))
high_mem=$(( ($max_mem * 9) / 10 ))
echo $high_mem >$cgroup_path/memory.high
echo $max_mem >$cgroup_path/memory.max

mkdir -p testfiles
rm -f testfiles/expected
xfs_io -f -c "pwrite -b $((1 * $MiB)) -S 0x40 0 $total_size" testfiles/expected >/dev/null 2>&1
expected_sum=$(md5sum testfiles/expected | awk '{print $1}')

echo $$ > $cgroup_path/cgroup.procs || exit # put ourselves in the cgroup

do_one_testfile() {
	filenum=$1
	cpids=""
	offset=$start_offset

	rm -f testfiles/test$filenum
	xfs_io -f -c "pwrite -b $start_offset -S 0x40 0 $start_offset" testfiles/test$filenum >/dev/null 2>&1

	while [[ $offset -lt $file_size ]] ; do
		cpids=""
		for i in $(seq 1 $num_writers) ; do
			xfs_io -f -c "pwrite -b $write_size -S 0x40 $(( ($offset + (($num_writers - $i) * $write_size)  ) )) $write_size" testfiles/test$filenum >/dev/null 2>&1 &
			cpids="$cpids $!"
		done
		wait $cpids
		offset=$(( $offset + ($num_writers * $write_size) ))
	done
}

round=1
while [[ 42 ]] ; do
	echo "test round: $round"
	cpids=""
	for i in $(seq 1 $num_files) ; do
		do_one_testfile $i &
		cpids="$cpids $!"
	done
	wait $cpids

	replicated="" # now check the files
	for i in $(seq 1 $num_files) ; do
		sum=$(md5sum testfiles/test$i | awk '{print $1}')
		[[ $sum == $expected_sum ]] || replicated="$replicated testfiles/test$i"
	done

	[[ -n $replicated ]] && break
	round=$(($round + 1))
done
echo "replicated bug with: $replicated"
echo $$ > /sys/fs/cgroup/cgroup.procs
rmdir $cgroup_path
