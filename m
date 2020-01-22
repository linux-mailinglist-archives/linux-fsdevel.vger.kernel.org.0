Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0465C144AC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 05:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAVE2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 23:28:48 -0500
Received: from sonic304-23.consmr.mail.gq1.yahoo.com ([98.137.68.204]:41189
        "EHLO sonic304-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728921AbgAVE2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 23:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1579667326; bh=nCHvtd0QNQ5io0gsWzbtEejjPWFblndOcTGFZxlrFWM=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=DJxW9d+sBpQVF6ztdCnLyOrcu1OXkJy+nWjBvqt4DV6MKp/MBvNhE5XUqTxKeMxJyzX1UAj2NqrDF68jh27fuWALFNvKQKtw8XXIiHEEbx6i/y/ojtXJcYhgWoOWmbPVgVrsEh3R2TvSjsaRobxbOpQ7PL4JjKm/mQRaQCY3vCK7nesdSpupmDNNIsrKyI2uAbRfLp1ZbRYoT7knPXofKt/5D1ai2Z81edpLSFkz9rKOt7ibwyISocYVTSNlAMr1xEmV9Cj14tMrtGxUO+J98cLxYbnj7oSEALSr4m3qW24eRcilEWlJY00yIiiTjOhB+dePbaA9uxw3mzJC+yt1ZQ==
X-YMail-OSG: IUZIvBgVM1nVbhxyreLep8QS0s52.u33tis5mperd0q_t5s2nzaRj2mo7EMNI5_
 XZ1QwWidJ_0puiq0hpsl5mxq7TfzHBubQezvZnNceIqSkEDZbYgcSwLQUbr06B0oS2izuNkVvseF
 Vp2GmMAuRQjM5BvfUZq4Qc424n9PzP.wrsfK..EoXaUN.bJKdp.b8AzKZYrLVukwpScNxgGO.yQ_
 CKyuW.zrPvyczS7JDsB3kJXPAh5jsc3melfUV2l7KJQTz70fhIB9BMU4_5_elDKpIkm1h805JRfJ
 KVs4qsYef12.JC.KQ49yrl60FXi8nDv.tqnSeY..o8ksrDmWfWtUyoyvQ_ArpW6MpAW.Yv0VhbDs
 B.UuLD_uNUxC0BZ5ZrTZtjYxWyLwjWg_9DuXvF3kst7niVgksDkRlmpsqaSW7dzznMKyZwOvUTSY
 2CFK9rq0_tzv5qBTdCJVSw9ZrbbcwVM1AcIfAS3sxOGpIGgWEDd4M5M2a_qqQXJGFNAHzNEF.43R
 ELL._nP5BmCXoQbahYHrw4.Tjgnsggw1PmlzkHpfXVBJYxZ.vaGgqO.kLkVlVOZl6tf_ThRJl8uG
 yZpp1OGMOEXe5OrVWS2Ye03zfTzcM8wptrUFBSYXJPswuD7_WNewkKzdD6wPIP.pxU807pdEb1SN
 7la3v27THuqi_egxKxfmglMnrUJDsAEbInDHp.2JJ690GIh6vU9QCUtHCrZ08rnKwQEIjsX1iffO
 QoS6RtSx7VwwY9vEhaXnIAD0e0kycxJJW1DDjw9PtYPVcFLsmcigk38AaR.QEiLkIy7oUmeLNSTM
 py9WCemAMbjUJanajYKoUy5_Re92K.BZBcJUq23LnnC_GctyRImPQw92.Ee7uG3Wwq0m_7qD.vKn
 eheGE47oPtGEUSDc5HRfw.BCu9M65riJTBrWo.PX4iPuGVRbU0a1bwOtXkokDGGRHiGasUuoN3Lb
 3rcl6yzAgfu.7lrxt_CE0Xg5Lu4bHOTqZHtWTkmg5KQnCRKtw3.gz7yv3Iov4wQYZSrDPnqLVnMX
 lBt8ckjX7fC.SCM8KpvPIjz16edCbx61piNScdnzbkdUP4Vs7TeCLS16a.nb6dHnSHABqtLyH_da
 1Tvr82T0fw7pri.Pk.88QjE5Z62K5B3d7lQ.ptUl9Z6zv5ovkfyS5yA1HMu5aZnY8eo1rM8uOssW
 pD56KJ8ytm9ImlamVLE8H1krbHPMKVIPEPNm1NMOKR3X52U7kojBUBL6p8g1GsYWK5yKbyBbESGA
 osjLw6vTRFWTjoFUd3W_rlI8BQ8dHA7DyfVhqnX9VvAmPBnP_dHI2E.mzaIkpC7ifV2rm62Ofm4d
 vBZ798lpBR3OpRsJXM8FFTBEJXh0QbBkGz6pIPGCsEPTBIjpdxdMCYttlUMcnTTaBwA_qqESdJul
 2Sngf3SssEU6YXC4PN1voI1lWoFAy4APUHGRg8mU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Wed, 22 Jan 2020 04:28:46 +0000
Received: by smtp422.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e838eed65838f6b8e509d224d1633db0;
          Wed, 22 Jan 2020 04:28:45 +0000 (UTC)
Date:   Wed, 22 Jan 2020 12:28:39 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     jglisse@redhat.com
Cc:     lsf-pc@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Generic page write protection
Message-ID: <20200122042832.GA6542@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200122023222.75347-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200122023222.75347-1-jglisse@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi J�r�me,

On Tue, Jan 21, 2020 at 06:32:22PM -0800, jglisse@redhat.com wrote:
> From: J�r�me Glisse <jglisse@redhat.com>
> 
> 

<snip>

> 
> To avoid any regression risks the page->mapping field is left intact as
> today for non write protect pages. This means that if you do not use the
> page write protection mechanism then it can not regress. This is achieve
> by using an helper function that take the mapping from the context
> (current function parameter, see above on how function are updated) and
> the struct page. If the page is not write protected then it uses the
> mapping from the struct page (just like today). The only difference
> between before and after the patchset is that all fs functions that do
> need the mapping for a page now also do get it as a parameter but only
> use the parameter mapping pointer if the page is write protected.
> 
> Note also that i do not believe that once confidence is high that we
> always passdown the correct mapping down each callstack, it does not
> mean we will be able to get rid of the struct page mapping field.

This feature is awesome and I might have some premature words here...

In short, are you suggesting completely getting rid of all way to access
mapping directly from struct page (other than by page->private or something
else like calling trace)?

I'm not sure if all cases can be handled without page->mapping easily (or
handled effectively) since mapping field could also be used to indicate/judge
truncated pages or some other filesystem specific states (okay, I think there
could be some replacement, but it seems a huge project...)

Currently, page->private is a per-page user-defined field, yet I don't think
it could always be used as a pointer pointing to some structure. It can be
simply used to store some unsigned long values for some kinds of filesystem
pages as well...

It might some ineffective to convert such above usage to individual per-page
structure pointers --- from cacheline or extra memory overhead view...

So I think at least there could be some another way to get its content
source (inode or sub-inode granularity, a reverse way) effectively...
by some field in struct page directly or indirectly...

I agree that the usage of page->mapping field is complicated for now.
I'm looking forward some unique way to mark the page type for a filesystem
to use (inode or fs internal special pages) or even extend to analymous
pages [1]. However, it seems a huge project to keep from some regression...

I'm interested in related stuffs, some conclusion and I saw the article of
LSF/MM 2018 although my English isn't good...

If something wrong, please kindly point out...

[1] https://lore.kernel.org/r/20191030172234.GA7018@hsiangkao-HP-ZHAN-66-Pro-G1

Thanks,
Gao Xiang

