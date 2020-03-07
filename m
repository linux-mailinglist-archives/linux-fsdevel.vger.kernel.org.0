Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B5C17CFB8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 20:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCGTAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 14:00:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43752 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgCGTAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 14:00:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id q18so5557148qki.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2020 11:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gS5lczqW/5ZLyrzLvsFcqFBdLI795hOrPyk+tNtUoDE=;
        b=qEdNziqUHkOaS/XCIgoIa3ryBFhDiMkJCJVd7jlTIhsVQqaY1/UyjO6ZM30/jbGXd4
         VN4t8IvaRqT0HQFIjXsz9nN20teWIUxXiZjle1gwivp5wL+v6tt79X5Ys/Rcn99XNixH
         5B3t5QCAX9oxVzCkOePmPaU20fFpjwp4gFSR6WllNQzHgccA5e9PW1PYLFgpgkU4KNTm
         jURJXBd3leEdvV12p+UPBPk/XdT6DyVMm7nijcewHCV27q5wW4PHGQX1pUGwJb286Qrp
         qpugcRPmpdk25X6wCaIXluOmyp4rkAcc3iR8yVal5/TSzTOFfnWhevEuKRcUC9YyszeK
         2zFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gS5lczqW/5ZLyrzLvsFcqFBdLI795hOrPyk+tNtUoDE=;
        b=VWHy+g3iJvGmh7oocs/OEgXqGijlilYDbT9aqiSeR4ZMrVM3l3ame5bhkYBDTqUSGS
         qKeMO+ScKCEonQjk0Urt7E3KHBK2BSAL+Hr9RpZdgJzS/0jE8D8kDxkpQPkKsl//5Ugg
         m1zxZq0D6icCCtl08thuwnuRAxpZgAj51nJWn5BCTVZB6hJSxIzFWZaT2AxyJ2Iu39XH
         v4zFskTsgSyjnP9p8BrjQC9xylZcXretfZS0M1tslbf3tiB+FiZOxD+MhsWwncFTXINz
         NC3rnr0BxLs7StaNjRdLRvj3W7Pq+1sT2BHn0/iBjGfgzUP844m+mUvzGnsUKa8PVYo1
         RIXA==
X-Gm-Message-State: ANhLgQ2fgBzp5UdBsgsdX+HXOy+qRLS034XEC7luphGN5zlgvbUFBmbX
        cCYvJktp7qLj2tKIH23Vv5IbBQ==
X-Google-Smtp-Source: ADFU+vvh81S1HGHOFAMq5PVC7z6OEObqJifaxMCKBnnUXmvB7EmXgiqjhes1I7itELtK8+DUNK5OTQ==
X-Received: by 2002:ae9:efd0:: with SMTP id d199mr1546917qkg.406.1583607627595;
        Sat, 07 Mar 2020 11:00:27 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::f209])
        by smtp.gmail.com with ESMTPSA id i2sm13218135qtv.13.2020.03.07.11.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 11:00:26 -0800 (PST)
Subject: Re: [LSFMMBPF TOPIC] LSFMMBPF 2020 COVID-19 status update
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
 <20200306155611.GA167883@mit.edu> <20200307185420.GG2236@42.do-not-panic.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2b4ad1db-dd2a-a42e-eb70-fa9a2dd21af7@toxicpanda.com>
Date:   Sat, 7 Mar 2020 14:00:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307185420.GG2236@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/7/20 1:54 PM, Luis Chamberlain wrote:
> On Fri, Mar 06, 2020 at 10:56:11AM -0500, Theodore Y. Ts'o wrote:
>> Should we have LSF/MM/BPF in 2020 and COVID-19?
> 
> I'll try to take a proactive approach by doing my own digging, where
> is what I have found, and few other proactive thoughts which might help:
> 
> The latest update posted on the LSFMM page from March 2 states things
> are moving along as planned. After that on March 4th officials from the
> county made a trip to Coachella Valley (22 minutes away from the LSFFMM
> venue hotel) "to quell public fears about the spread of the novel
> coronavirus", and announced that "there are no plans to cancel any of
> the upcoming large events like Coachella, Stagecoach and the BNP" [0].
> 
> So, hippies are still getting together.
> 
> How about our brethren?
> 
> If we have to learn from efforts required to continue on with the in
> light of the risks, we can look at what SCALE 18 is doing, taking place
> right now in Pasadena [1], their page lists a list of proactive measures
> required on their part to help alleviate fears and just good best
> practices at this point in time.
> 
> The landscape seems positive, if we want, to move forward in Palm Springs then.
> 
> When are attendees supposed to get notifications if they are invited?
> 
> Since the nature of the conference however is unique in that it is
> world-wide and invite-only it makes me wonder if the value is reduced
> because of this and if we should cancel.
> 
> Does the latency involved on the confirmation of attending decrease
> the value due to the current haphazard situation with COVID-19?
> 
> I am involved in other conferences and am seeing personal driven
> cancelations for general concerns. For folks in the US it would be
> easier / less risky to travel, so my concerns would be less than others.
> But -- would we have higher personal cancelations from EU folks? What
> are folks thoughts on this right now? Is anyone in the EU not coming
> at all due to concerns who wouldn't mind voicing their concerns even
> if LSFMM continues?
> 
> And then there is the other question: can we cancel? Or is that
> economically just  too late at this point?

We on the PC are working very closely with the Linux Foundation to make sure we 
have many different options to choose from.  As you can see on the event website 
we already have policies in place to protect ourselves if we do decide to have 
the conference as planned.

If we decide to make changes then everybody who has been invited will be 
informed as soon as possible.  As it stands we are going ahead as planned, but 
preparing for alternatives if that becomes unfeasible.  Thanks,

Josef
