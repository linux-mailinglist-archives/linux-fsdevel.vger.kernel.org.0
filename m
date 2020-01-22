Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB05144B79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 06:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVFwi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 00:52:38 -0500
Received: from sonic308-8.consmr.mail.gq1.yahoo.com ([98.137.68.32]:40021 "EHLO
        sonic308-8.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbgAVFwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 00:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1579672357; bh=m1TngP7v9QL/OgWrRHhkzeVM3vncCixxyVZeB4KwRZ4=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=qo3RdUCxF4AfHSJ5PSS/h/k33yZKiOCo7go1I0BIP8Z/He3Ag+pufxCt8LoQY4Kpok8Zl5QklM4G/vVvRpAm3Yj/N5tKZ8KU8cZchg0v/Pt4hE4R6hMojfthZYegxoWcAuw/JGpMiSjmUqyd2oO4NNmdBuK6dcP+WqdqILPp9tWnNUmCugl1jplDHSCgxFRssTYax+qipLBGxRd0ULe5xUdx9TRYHyuktfllE2jRvwOPQfCEkU6ijUc1qvs0fBvrCPX6MqJgsoiCsAve644bzjYicM66e3QSErt+twJyStESQ8BTF1kL5Skp6kOPXeXRzATac4jyGIMkvLI/r7nGRQ==
X-YMail-OSG: kwOrWiIVM1kPRerBHD4KV9c_.znfhEmpefevnFHuDik7P5OFlUXAXUJLBYqoAkN
 YfvtpUo7brnrE3UmtMyrNBvnOtEYvp7.kxu_UISFzTFbAlAUczh7T4gmXGX31.qszPIlMLdgIgGk
 zqNaqkgohImF8MZjxw_UXEV0S8dyVSr2j1Ez.n.1cND4Zn1i7zmv1moc8c0afpJw.snY1i7CUzvf
 hy_17BlL8lQPpc0u5WLOksHvAz0gffAYJcp0SSsys.ubkzvmPxRECQ5GulZ8GiSY6fVOwGUIJHg1
 fbRbIF0VVLaLCTNjqS4AuBISq2enpUAsQ4uKjGyGF3zLQfZ.cUvOa27oYQvNncA86hHiEQVacCrg
 4xm_CHZWajHb8Tp1gUH5ii_Fl3eP6nCrqurqT2fvZ2OZCkDe.a1paouiFUG09vRL7dKEwQ51qc7W
 zu6l1AwFEI8XKv.F2ot_wHSRvKJjMC.Musu5XPVyXTq2OyPNKww7scvyx9RH9dujLqZbRwI3BRG.
 SMVDSkbU7mDOcRWuUPS2FW.QNc4x_33t.TYLppd2ktpbYeLetc7b9ycfT69.wyBI7X0F27tItgzW
 TNlyAdzT6x9lgrEHJphE83ZPJYKHQVwRkl_x4h5HkufpyYXvIhPiiP5uvY6QpFZMxlhj4ngto.Jp
 WOrnthc5DDqiDcGgk0M.v8UNZAJHQqgqQdVTGdMsk4go06p1h7bMkIPXdwEpSSKboBJd3eCekF5G
 3fGj2EovVNEnTR0oCLB25bylgXMUkevOpFh8lM3mJ2iOnMZPbLd0MebUdfxelUtFrTqZFgUODTez
 x.Mx8bDDQMrCPtDZu7.TDnFjlKzn8dwzUK2bSG3i4EUR5R2soVlYB7UN0iPi3BSpXGvlJwfXs6Ws
 PqdUhhGf83ijlZOjn0.5leFqStedC1mSqyXmOcAaf7YPBtP6Ckl6QI91Xf9eHti93m6P5rJKOvDB
 adB8UBzcgEG_nLAzeaUvwuj7rVZVjs3TbCNVvVYUCCLsnvgIbMtYVO_ih68Dt3YH0qs9_XiWmrzZ
 S.xWNbzT0ICWcZ.MVbvFJaxWXku.IaURXYbdgqZtWZLxRF5vR_4FCuEwBar1SSWdgOM0fuqkYglO
 aSUGzDMlP2._lnFXoI8YskG6YNNNOAiVl7BmAOVSTQHc9ouR7AFdFbpZYth75lVb9cPM0twsTTBY
 bRBm8Qt6s15c3sgBNh6jAZqVB0rwVh2lAZNv0qSHlCOdNHwIQVnteXqefuzCCkKCZ8T3N50C7TY_
 5YXaJ_dNT8gEVk5F6Ev5vJ1GfGq_PD7iy2HdBDGP4FlmVxT8uMPgieXqNSK.M5eRGKx8b53beTIM
 qOi5s7xOAi2PJ3Rb2NZBUKZ7n1uxqTbRBG9Ywc2SY9xckf1wHInVtqhJfjDXwN1rNorILg_6wIaB
 SufA6mQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Wed, 22 Jan 2020 05:52:37 +0000
Received: by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4a02ce608c48d5a20a659077844e8e1d;
          Wed, 22 Jan 2020 05:52:32 +0000 (UTC)
Date:   Wed, 22 Jan 2020 13:52:26 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Generic page write protection
Message-ID: <20200122055219.GC6542@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200122023222.75347-1-jglisse@redhat.com>
 <20200122042832.GA6542@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200122052118.GE76712@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122052118.GE76712@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 09:21:18PM -0800, Jerome Glisse wrote:

<snip>

> 
> The block device code only need the mapping on io error and they are
> different strategy depending on individual fs. fs using buffer_head
> can easily be updated. For other they are different solution and they
> can be updated one at a time with tailor solution.

If I did't misunderstand, how about post-processing fs code without
some buffer_head but page->private used as another way rather than
a pointer? (Yes, some alternative ways exist such as hacking struct
bio_vec...)

I wonder the final plan on this from the community, learn new rule
and adapt my code anyway.. But in my opinion, such reserve way
(page->mapping likewise) is helpful in many respects, I'm not sure
we could totally get around all cases without it elegantly...

Thank you...

Thanks,
Gao Xiang

