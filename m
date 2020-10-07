Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770BE285A31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 10:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgJGINf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 04:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgJGINd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:13:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A274C061755;
        Wed,  7 Oct 2020 01:13:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e10so920293pfj.1;
        Wed, 07 Oct 2020 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aObhDWq+952zOEk1Dbgb/RY6DzpjbMzmFP6DHRLyT8s=;
        b=jnBgLxK8LCSMcjWVAaR8C2tTQYCen0tg7v8CvuYvCO5nqF5x792pi2vHv0mdsA9gPc
         Ock/JjL2oh+ztPUXL5fccvfXtrIdsHBMIItEnQsNmkDni3rNZXbnX9Le42IG4NtP1cZ2
         zoNsX4BIXbiA5K51AW5vs2MsePd9vobMcZPTa2LbkScAwQ8WakCF8fWNsIQyBLBzagBB
         2tlIC7H/tGED8TFfMlpDbL5kIdeyuKAC3+S16v3DtZeAfA7gIBoj3cxvo8+pDOvvnYln
         CsbuLeuoPoZkh4L0I4Wo+vwZAYFJoTlJ07Xw/7jMhQrTiXipEZJute/kvq8b8IiGqNMg
         o7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aObhDWq+952zOEk1Dbgb/RY6DzpjbMzmFP6DHRLyT8s=;
        b=EObLZh00+LkHyGByeiiHMdF9lE7WUCLK0ccPQZbCptJVGhMYb+jvuo4vApNpEuq2Tr
         0swjsqADfjYeB4VgaKxWQoSg710+8OhFyd4/G2eKUoOipB16w2IvBbzDCuwiRC6JVMIJ
         a0DYXKLoS5d9lwCuxS1d6WiN2Dim4HGygfB/aNSFau4jZq6AeV31JOrNQeYt82qiAkvR
         OACueVaBUr5W7R3SQVd+IC/2F8wJ8IzcRiIqzGpgKjK+7mX9p906hyH/aTYmbf68fGzm
         yxh9skGfBsPi6Xi+nqUn6M+YNF4HLd4bnDCkEsqZV7ZdKNJai23DpGvW6gWF+SomuUuZ
         LQlg==
X-Gm-Message-State: AOAM530uTQae9VGtx9nKsSWyTEG3rFhDSP+v/WxRBo9xHvibywlV8drF
        7OAe5u3oCF/7IGet8L8b10J5/iP7nyjy8A==
X-Google-Smtp-Source: ABdhPJzi0tV/pskRbOZtxEM17LLWCXDdYbzAjsqxYzHTdy5PhRkeGbFfyzvJK/aG3g8CzgfLABHPaw==
X-Received: by 2002:a63:4e4f:: with SMTP id o15mr1948563pgl.202.1602058412223;
        Wed, 07 Oct 2020 01:13:32 -0700 (PDT)
Received: from [192.168.1.200] (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id x22sm1869920pfp.181.2020.10.07.01.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 01:13:31 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] exfat: add exfat_update_inode()
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20201002060529epcas1p2e05b4f565283969f4f2adc337f23a0d2@epcas1p2.samsung.com>
 <20201002060505.27449-1-kohada.t2@gmail.com>
 <000b01d69bba$08047320$180d5960$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <d19ecc4d-968e-9341-aaa5-a6c2c541eefb@gmail.com>
Date:   Wed, 7 Oct 2020 17:13:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <000b01d69bba$08047320$180d5960$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for your reply.

>>   	new_dir->i_ctime = new_dir->i_mtime = new_dir->i_atime =
>>   		EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
>>   	exfat_truncate_atime(&new_dir->i_atime);
>> -	if (IS_DIRSYNC(new_dir))
>> -		exfat_sync_inode(new_dir);
>> -	else
>> -		mark_inode_dirty(new_dir);
>> +	exfat_update_inode(new_dir);
>>
>>   	i_pos = ((loff_t)EXFAT_I(old_inode)->dir.dir << 32) |
>>   		(EXFAT_I(old_inode)->entry & 0xffffffff);
>>   	exfat_unhash_inode(old_inode);
>>   	exfat_hash_inode(old_inode, i_pos);
>> -	if (IS_DIRSYNC(new_dir))
>> -		exfat_sync_inode(old_inode);
>> -	else
>> -		mark_inode_dirty(old_inode);
>> +	exfat_update_inode(old_inode);
> This is checking if old_inode is IS_DIRSYNC, not new_dir.
> Is there any reason ?

To eliminate meaningless usage and simplify it.

Th exfat does not have an attribute that indicates whether each file/dir should be synced(such as ext4).
Therefore, sync necessity cannot be set for each inode, so sync necessity of the whole FS setting(sb-> s_flags) is inherited.
As a result, the following values ​​are all the same.
  IS_DIRSYNC (new_dir)
  IS_DIRSYNC (old_dir)
  IS_DIRSYNC (old_inode)
  sb-> s_flags & SB_SYNCHRONOUS | SB_DIRSYNC

In exfat, IS_DIRSYNC only works as a shortcut to sb->s_flags.

Even if S_SYNC or S_DIRSYNC were set to inode->i_flags, the current implementation is inappropriate.
Whether to sync or not should be determined by "IS_DIRSYNC(new_dir)||IS_DIRSYNC(old_dir)", I think.
(Syncing only old_dir is a high risk of losing file)

Whatever, no one sets S_SYNC and S_DIRSYNC in exfat, so the behavior is no different.

***
Please tell me your opinion about "aggregate dir-entry updates into __exfat_write_inode()"

BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
