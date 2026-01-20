Return-Path: <linux-fsdevel+bounces-74630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P7PJCtkcWmaGgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:41:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6555F9ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9404276CC49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 12:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAD342DFFE;
	Tue, 20 Jan 2026 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqL0zhuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C03428480
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768913538; cv=none; b=uYwNpuJAEFyFPaNwyrW3zTJOeaaSEb33LPhLcmXuqMJHg/IOUXsGNblP2SUwZmfJyrxjVGBgPtQmdJVLFFVdc4qAkhgZD9Fsmdvf7eukMg1yCcwjLa+99EDNoB/qQsO3Z2//+B41nWIxhlY6Yqton2ekEZ0w9fPoeKGjLMz2gVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768913538; c=relaxed/simple;
	bh=qwRTDcexgqB8UO6ImlZARduSMCBdN3aQSsAG3RPO/qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNyuINBNrBli0IYGG5Jbmn0K2q5ZFMOza4gGwjJ44DTaBxNCQGbHZDwUhVnikFSDlPLaaMuLoSYfPmfU+cwmWcyIrL7G3H6Qwlc/hB54A5z2ecZzWIOuCGWtRfu7iBH7j55y9zcpA/Oq73XO0t5JZXrJfpRTzchJC/P55Vd5NU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqL0zhuF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47eda5806d7so3001705e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768913535; x=1769518335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hohucwzV8N+oNhlDNJ0PPwzKcIESBcXAG4tNEyAv2Lc=;
        b=YqL0zhuF2uJZZgUy3/UvpIEkp8/CM7WhpfH7rNlFaKLzczlRpfhxsCI66ngAhcpyJg
         12yuJAmCjmuzJIQGIZ5cV+6v4zlbOJy1ve8lrVNd5AbgTug7FPM5GkSdvVm+oQtdmPcq
         IwIqInMDB1vdans4Hm6qDnk0cq2qzwo5gbltYgxYeZn+qDUGA5LAVOz4qd8jAiAxKwH1
         SqgAVKmbBKgmu45/d1b46PuPTY7eIabm9z9isps1qEk4XDRzSsDor9Isl6HMuvWZ73Iv
         dQvGTLZlSbwJcaim3TNNMHn8YtgxmzaDnkeqErDozLm0AEZFKy4cExxTsbpWh5Z1AmHa
         d0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768913535; x=1769518335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hohucwzV8N+oNhlDNJ0PPwzKcIESBcXAG4tNEyAv2Lc=;
        b=LwJts9/fP4YZvJtAYSSr0GKTraRMy3NiDElnGFpXy/7kbLuXG6o5VZascPlnSTsYEQ
         zMGHVhV4YXjlenkSJ1vmP0CiIejHsehUz0UO0W7N9YId8MGYLZ0sjT5A8IcdGWYsktaK
         wnGKjDqA+8TGrlbIKdYa6aDvLWdagT8tT1SsplO83UQVZHp4tfS+S4nmKqggz5dXJcBG
         P1ORCAl1M+unMQmsT/jkg1gLdgrhvFI30j3ZMFo6xRWQG9tgEI6T0QZhtwWy44xcLEgJ
         sCZMPeH9WrvxH+/LHruGvEX9J5DP402kXzBUvno/FYdEMpPS6FFywEe4tngeiM0CZf/r
         pcTA==
X-Forwarded-Encrypted: i=1; AJvYcCWNEW0IpAyABYHBu+e1K+Aiq+lBtsWS3RHYmwniRcQLO9W1KjjJVcI2OgHpzbTIQBtlfSLEt3pl8Kq0IWSm@vger.kernel.org
X-Gm-Message-State: AOJu0YzUq4gxk9pUhQX0SH3ysp/7ddyOMJCI0VmlRBa7iwAuo2Eg3CQ/
	3ej7z7IgHpEF834tOs/45v+H2KcbG4QxjL8FUMy2o3MzrXY554380cQE
X-Gm-Gg: AY/fxX7+WXUZNoXo3Jz5ofVU8hSBhUaXs4IFoBfHOAzem6qteY6sTAhv6P2IJ9cefCl
	IwQIh6La06dlGVeVaq+3WbpdtWb4u/MPWSD4vtK6dW8KfKFmbir1Hd5cyBDbo0rPiK6Z/7gAU4u
	UkFOcvJw/k1T0I+p1knyqQgmPXRZ6WbgW2ZlYp/ywxDid3GfWNZhDPeLIpvPb6loeQdjRoDjsCW
	fHjr6vAytmyEWTFNP9BzdU1RnXu20zcYGgbrd4GpS9yXGi6z43dqaSL/IgTqQg6I00vHR9Fo49f
	DOnnU2GMm6YipUwCpcnHrtffiFFJp5jkLCeoH8mFTjlXevmWp0IEXCdOvpLbZgDmBWITsBFD6jg
	wT0bpaEPnjPkn7g3b82g+GzwgbJw3gLQ2L2+r3LykVnB5OgALbz74W5V8E8VsQE0uY2852oktcS
	USqtX2VfCbYSMtHwkc3YtyG6NwvfmdtS8DPCRN+Sw=
X-Received: by 2002:a05:600c:828f:b0:477:7b16:5f97 with SMTP id 5b1f17b1804b1-4801e2a2216mr110600595e9.0.1768913535151;
        Tue, 20 Jan 2026 04:52:15 -0800 (PST)
Received: from [192.168.1.105] ([165.50.95.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43595e0a705sm1088207f8f.14.2026.01.20.04.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 04:52:14 -0800 (PST)
Message-ID: <cd4f1173-d5c3-42c1-8753-fb7b6c6ebad8@gmail.com>
Date: Tue, 20 Jan 2026 14:52:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super()
 failure
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "brauner@kernel.org" <brauner@kernel.org>
Cc: "jack@suse.cz" <jack@suse.cz>, "khalid@kernel.org" <khalid@kernel.org>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
 <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>
References: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
 <c19c6ebedf52f0362648a32c0eabdc823746438f.camel@ibm.com>
 <20251126-gebaggert-anpacken-d0d9fb10b9bc@brauner>
 <04d3810e-3d1b-4af2-a39b-0459cb466838@gmail.com>
 <56521c02f410d15a11076ebba1ce00e081951c3f.camel@ibm.com>
 <20251127-semmel-lastkraftwagen-9f2c7f6e16dd@brauner>
 <4bb136bae5c04bc07e75ddf108ada7e7480afacc.camel@ibm.com>
 <59b833d7-4a97-4703-86ef-c163d70b3836@gmail.com>
 <9061911554697106be2703189f02e5765f3df229.camel@ibm.com>
 <7d38a29d-9d81-42e0-99c1-b6a09afe61fd@gmail.com>
 <8a96ddbefd84ed0917afc13f91ee0f33ea2e0c10.camel@ibm.com>
 <4e65ea7b-79aa-4c36-a8ea-0ca84966d089@gmail.com>
 <d714e0652f920cecebf5fdcf0023a440cbd1df4e.camel@ibm.com>
 <4d545c3f-50cf-4ad4-8427-35f87398838e@gmail.com>
 <1bfac55095419b8c5d9dd73dbf9b8b94c74b264a.camel@ibm.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <1bfac55095419b8c5d9dd73dbf9b8b94c74b264a.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[33];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,vivo.com,vger.kernel.org,dubeyko.com,gmail.com,lists.linuxfoundation.org,zeniv.linux.org.uk,linuxfoundation.org,syzkaller.appspotmail.com,physik.fu-berlin.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-74630-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[mehdibenhadjkhelifa@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel,ad45f827c88778ff7df6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2E6555F9ED
X-Rspamd-Action: no action

On 1/19/26 9:55 PM, Viacheslav Dubeyko wrote:
> On Mon, 2026-01-19 at 22:34 +0100, Mehdi Ben Hadj Khelifa wrote:
>> On 1/19/26 7:27 PM, Viacheslav Dubeyko wrote:
>>>
> 
> <skipped>
> 
>>>
>> I have ran xfstests on both my desktop and laptop on the for-next branch
>> for the repository that you have mentionned and I didn't have any crash
>> or issue. Here is the test results(identical for both desktop and laptop):
>> FSTYP         -- hfsplus
>> PLATFORM      -- Linux/x86_64 bhk 6.19.0-rc1-00008-ged8889ca21b6 #1 SMP
>> PREEMPT_DYNAMIC Mon Jan 19 20:53:58 CET 2026
>> MKFS_OPTIONS  -- /dev/loop1
>> MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch
>>
>> generic/001  2s ...  2s
>> generic/002  1s ...  1s
>> <skip>
>> Failed 51 of 772 tests
>>
> 
> The 51 failed xfstests is expected situation. However, if you apply [1,2] on
> xfstests code base, then you could have around 31 failed xfeststs for HFS+.
> 
I have applied both patches and got the expected results on my desktop 
and laptop:
Failed 31 of 772 tests
I can confirm that indeed those patches fix 20 of the previously failed 
tests.
> Thanks,
> Slava.
> 
Best Regards,
Mehdi Ben hadj Khelifa
>> Many tests were skipped of course. If you want full output I can send
>> you that.But for now the issue seem to be resolved (for hfsplus at least
>> I'm not sure about hfs since I still can't test it on my system).
>> Thanks for your efforts slava.
>>
>>
> 
> [1]
> https://lore.kernel.org/linux-fsdevel/20260118180519.xdddwoke2tey6ogt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/
> [2]
> https://lore.kernel.org/linux-fsdevel/20251231224937.uu67l76cytcd36ns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/


