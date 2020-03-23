Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63E4A18F90E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 16:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgCWP53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 11:57:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44012 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgCWP53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:57:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id v23so2031713ply.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2020 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/xdFeUkMil+HXZ4ax6FoPNFtoFq6FUJmJ0Q6Zva1VrE=;
        b=ldgxYSTapIFo5c9XASqPk/M1zo3L8kU4x3tLHAuxMZ3Ni6aYrfoaqEhE+GIihzMifA
         hKtcxmeGZgwq3VV21jgiUJ/leOO59zn8qHUpukZvTMgPXL0f50oYzRetsOj5RfOr5wo6
         hNb2+NEVCcjd2OVVKPiwQIVBfHMX/axtpRPHrL0Iv2sk/crj1nPyEJwsltNo8Ft5pDwy
         j8dYEZs68r93tzXRFm63Z6c5zJYZSdMkjkPqi11eaw/AP3CgE2ixd1CcjUbk8aUlSkpP
         zPNYtlRNtuG03yRkgo7ud3aFj9FsPNJD68IweJ+zZQXlexokaVicwjJKyLBKLNp4g1CL
         +DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/xdFeUkMil+HXZ4ax6FoPNFtoFq6FUJmJ0Q6Zva1VrE=;
        b=jP+egsQo/H5DG7bblOL0xj09nyT9ByAPMR1587sLs0qL4Lee1qrbGW2lMW10ltgokg
         gIAalarrreEjNPq4DJmuMGDQHhza8HfK4DUXLCUKvJGLggRWPvJADp8ysElYXNnVYF6q
         Iv0b/AEYZJYwiTzoUyIZAqWe22zP3Lkp9XBvZa+Hc7ga8Uk5kcMlTlrDaH9nAeQNaz9l
         BBxLGm+XBDRYggL3TDvCxhwMRspOy6JxT8vDHeL08CF4EYh68oB/tPaTXe/gIKWGqgIU
         NtqqZmvU/fBf+znccicCkJlJmba7G8A/FvaezWc7SopLsVQw7L8qSufyKec00NIW/rhN
         27Aw==
X-Gm-Message-State: ANhLgQ2LkDgCgUcExZSFXWnjFLWN9gMOwScpbLFAaL27DGqb0+r7w/+f
        KUtp5m6wMB5j0JjWNXXawrmDVA==
X-Google-Smtp-Source: ADFU+vv2vW47TMHyado3xCQbCSqIX92ldURxbW69S9I1oeWxT4bL7zUy0acMpY+x/kqHktNpZ7+cSw==
X-Received: by 2002:a17:90a:2a89:: with SMTP id j9mr7994pjd.64.1584979048199;
        Mon, 23 Mar 2020 08:57:28 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id c62sm13653239pfc.136.2020.03.23.08.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 08:57:27 -0700 (PDT)
Subject: Re: [PATCH 0/2] io-uring: cleanup: drop completion upon removal of
 file
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+538d1957ce178382a394@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <20200323092419.8764-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f98097a-b3f7-fc8f-4a84-f848253a0e56@kernel.dk>
Date:   Mon, 23 Mar 2020 09:57:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323092419.8764-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/23/20 3:24 AM, Hillf Danton wrote:
> 
> Kudos to the task hung reported by syzbot, and inspired by it, cleanup
> is made for dropping completion when files are removed from the fixed
> fileset. Another cleanup is also proposed for dropping the done field
> in struct io_file_put.
> 
> [PATCH 1/2] io_uring: drop completion when removing file
> [PATCH 2/2 RFC] io-uring: drop done in struct io_file_put

I like it - I applied, only changing 'done' to 'free_pfile' to make it
more apparent what it controls. Thanks!

-- 
Jens Axboe

