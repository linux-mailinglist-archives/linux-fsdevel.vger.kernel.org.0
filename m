Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C142D9F7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 19:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440160AbgLNSqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 13:46:48 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:41450
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395074AbgLNSqf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607971548; bh=P6YkrPT5uA6xxgGjT0j4A8luoT/rgVDj8d9AKZCndQQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gD0EJfovHcz3qsa8+eMNJjx2drp3AU3Ina1cfHT/ks9Z3TgN6gysHm2SJasEDSEDBGP4rghDCFh02O3VaSYG7BMG80JfWDgIFAo2lxTvj7ELCq/rGZUcylHNZN9Mh5QflD2sL4AN3/a/TrO/jeRRsnTtmCLbEs+BvazHmvS1WxD5/4GXIn6bm0etONuNL4Nmcrl+VhcJ1tNcZpTb6kVJAk0MFWb3dVjy1dYbjXCy2h02Su/99rLDD0dHqKsZlRiKGkPoTqZ9bXf89oqowQzSK+fjZ3lhp9uFgk0J66QmkKRH22Q12hOM188XbiEJwhvNEDYcqP0/RCBjhVw2ZR/mog==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607971548; bh=/OBwNzribKawewf0yP0CIZX3lxcW2uBUaR/pqPx9HA4=; h=Subject:To:From:Date:From:Subject; b=Ns/217mmg0911FZ8WbHOLCfklwn84GUbN9Z0eyynGv2VJZqeFY3ZmRxet7g7w/QwMCDnYsqyrApgE30nYR4l5VVIhAPd5f16S5WE9kxjqlNOWQORFtx1nXci3/BxSw6DyiLWcP6P58lfWj4ne2nyiD+12JPkdIzeAqIar9DEXkfUDnVE5EtJbkci27+gi/XiC+7xiLzs+NiTtta+JJnidQFXsbZhHMWFItCEtINHkqAZTPui59QxVGCn0ogPjt5qV93f/r5p3I/LLXcOEcZTKB4Q2VjMO90SWxkt2ip4UI3NMK/Dlpynwd5Eo4BvOVcHd9XAXjwK4CFiBVq5Wnwu0A==
X-YMail-OSG: Ami_UT0VM1mwjRcaCIpKoS.69wE7nLWXyDrJXY0HjBrmScQMO1VcC6VBLEb.JZp
 1ontZBpTvmrmQsCc6QSdWdAtt4Vzux5VH1PwBvSAiRGm.lYtswn1H9455Ic9.sjMyZ_YUSGVl6Cw
 Gv_U4rZ3ugCc0RU6LlttMn.5PXRZXM0n9b07BlBndx.7mVKdISsKRzMhbz9mLzO9.UNxK_pqA5_z
 J40QI2uisbtT.m4Eh2XO7cKxTk1v6lCMeIvHZralisHeduDXZf.5a24rPICDQBUZ7REnYkXv250j
 6fLbukJcJaEhGau6TE2M3x9RS66kp9UqAzHZO.lgghZpg..KItGXuKNyhD09dpHni0jNVWmpMTok
 UtHCW_GiuQStF84fUQd09VsMVZIb47auyMqiOHm6d7_Ahe5mmpVab.1kGs9yeaVJXNsHxHFv6lbe
 JICKoiUNN02lsRsZgWDl5J6bbTtAVHQpWMdjy5ejoJmiyFw3KwkXwc2BXv7CirfWY0B9Syu82kVP
 QDPyqkCJm0jA9UzROEAUiC6rMEZGfxDQA3x.X7USr7rTdsG6p8G21Bfyv4hNucXvWFHduHahRs7w
 JZgIvJ0O31d2Ey1Bfqlo1NsRhL8fD62uG7Lzy8tPCOgE7g3328f54TuaylGDGqu1tsGptlEQaDT2
 e.MnwERS5Wh7iAPt6xvzBJraAoqqSjwMYWw.N7mtWthjO6Y0j6dr6S4hDdGWTqUcLB17_SRQnfhV
 Vz_N_ifbyFxnv4Va5YZlO5oSWedq4F3TLIqpGXx3Ly55ccdSevtfc7XRuyDlkVTwRwCXK_4NZvS_
 0XcZFfQoUXbFDlSqv0Ujaba_csQeZhJAnvYUUYz1EF18MXDnGPKSJzDaT_9FsL83K64_xdxu4yxw
 nJ3OcptX.HrwlNogXgM9GVjs4_4YszqPndMuMWuBju1Nq2wkJvg33HMegOsGASGUpwLc8nvQTbKT
 Dkg28imXBzuqqKJAoCq8KfDC.3OBgNOhblYxAwc76HOet23Z29Yr16qxacjUQeeDunRj2yrnro7x
 sazeXF3CzLZz4bH6ldWjyj1TUT7Ge7DIiirjVFbjUd6u.PupElOmwdJELOUpSea8jPhO7XuvXLVM
 NYa3GwScpSi2O7d3XdWHB6Jcz5WSy34MBMrlcu_aKr_f_DeP8rtZ81NSEMyX.A.CSJ21R5L09goK
 vajyYoQ8Fc0hG5GLYPExGRWJ53KDAPPyju_r73Pirdh4bOXMbM7_JhJC2k.EnrBtPol40hk7rzlt
 YbUJouqEe6.fR8_2eYpjGNjlQNLTn.AadXhNFNS6gaPqN4OP3SLvmUo4ELRdDgMim9_C5JO1GFAW
 6GxILaDWcNYQ7C92_4u3uKCCHzDpOGo_jLF6WIHZXR8qLRgRGI0C.Oc.9VVFg1F_4fOgEpLoKhqC
 a9w1yxY1SLdsdXG0DjS1mfNntBA.S.iPKvT2UFHIZGdQg4mUC4RFsJVsx9msW_S1Vz0fBm59NocE
 j0hoUA9x2T9ujYRZ5w_GrKoxupLYODRZvNXQfOvDL1lGo0vCFympYQwh5zniLqiXONoqAQ7vQGKE
 jdgou53ZX0vJVo2Ag2toXvvdG.zerCjxFFkuVTGYOWm7kFbK0umJaipIqXYiNhC_6p8mWHsonSNH
 wmxZgGo5UjCTw2P_BhRCI4qDEyJu8NkB217ryTGtHNpXfgpXgm43f6n6ZAJocQm10FqzYLDlnj8f
 pD6bizUHUKatuqjUbHLxPS6X969MVK63mJLfGlPND0z80.s.tdv8LGB4OOwJH0ykyhJbjEzgst6t
 vA.SZ8c0kvEO5.uGYYdzNIpkySFf4tlvZYWSyagttXM0THsJXj4FZSUiFu38klQcrklGmQxGCMRl
 2GbP3iP9P7D0HfI6jnW87wOUbuYNtrlRyuVlwsAjA.gnQXNfsomSrNVycqCZI0jzmvg8m8Jr5fxl
 _P72hg4DbicrNmj9VFwIa9f0s6UMTEhvefw1S3iPt75a.0mRJ4XkHyL036bjodpfJqM56xFvAA8T
 RT2DZp62EBCUYTQEg9bbdPi3nohUdcLNqBngYknLxIHd0OEAbDjSRMkmLKSK8lBCaTBSH7pFnA9s
 n0pnsBMYvhXexVq.PnpuxHholxZTshW6Bw.eQjf_HHwN3Tu042GJRp5MYEMbr5pv9WqQ3WlJHu6O
 zUWLM0pNtHVycn9HWgSz5Zkh2wRKValrPofeWyBiY6yq11fvocL9iOa60jtY8KJSooOH936rfzD_
 c1oVnTGluaUJarDjLTrMRQ_SNrtIDDASqASFrZNOWbS0WMUOSCTyV6Ak9NQGHlF8vFX_eHjBL6TJ
 0WigKWF5Z_X0kY5GgiVWVeKuSUDQT9xEm7nabAkdjy.TqLC2uNQpCAdzU12_p3xSfaBK3pXbf2g8
 Jyd9bxougExI6nwXS6RAfrHGi0LHIdyvvQ6Qgsn.POa6oLOZDkkPETpo47twE01Rz2RUY2QdBpQx
 1ZmiCBBHSZQJpJbicDeJoZ_K2Cf_cMU_cERI8gFFTilemVm1VcR6YoaBjSIir5dLCJRAdCCwQs8F
 ujcnmtW6q0mCQh2h1CwHnOQnW5ZKj2zqT.IBhTGBwHO3BbtIz8zER4p9ADhD_bLOfyRDMXXx9EK.
 a5CQuJc3aL3ZCcgKvqL4xGsKxb2baopvAJtqctybdHa9mFDut7Vq8OdGFv_qyNBHjNGJPnaP4Bqf
 tDGUZ4Rw0XJefh.RQZD4.OhSyLOKZZ1vmD5tfylrWIRAUEl5pv2gzKDGpn3IWV7rGBtIqcoZEUZm
 bV9V.CG9u2awDNQuq3s2bUifgEjmguco_zJlthKOTBeqfDJqLwQhvIHFX2vC0.DkOgBqzwGi9k5d
 DpYVYxf3rP_hIc.9uBxBm4y6Z7PDlKY2mbXS90U8tjz6Eh1Pfzn_qSD2XAx9_nDC5HMiAa9B1jIm
 mIXtgFhmP_cqAHx2CauOpE2DvpUslIf0wrILC2FXT_k3VgUyatIzne6fDFrhn3.9EF_BHPbMEcSY
 llOBN1YPYQhK1WJV5O.Pq22VaRnINyniEgqcRr1A0LoeWaA0I.nDFeplhqMVcm8ub79idJ8NjiQu
 PtJ3YkOBXnV_kyGkw_.vuWrEk2B5taXRhJkoerjVu_0Wtywyw69RBQXPQCm.PTXbqULsFqQcyUhA
 atlMObue3yMeHjUGxxzxRrAWPwyWLabHJG36uRrZZ7NDpf3T60gBngiNStknY1GkfeQ6xOhY9R_0
 7W38F6LU2PouU0Hv1gpYoJKx3TN7A_E0cWG2N_WfFCr7h00.CIpaa15UdPcJIrjUZdN3b.XunU06
 maVk_HJkVtxgt1iWnrXal5VDejcm4wFPTqjGzR6KiT0PEokiiZ52S2YLG8YlPFbYASnvKm3Ap0s2
 b7KoqixbyjctTxLxp4OmA_snkxK4Yu8KvL2y8lFezdq47m3yF9l99pT3wkY9BIibKRbe91a2SLu8
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 14 Dec 2020 18:45:48 +0000
Received: by smtp411.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5cc7bf86203920dd4d4da35148d929fe;
          Mon, 14 Dec 2020 18:45:44 +0000 (UTC)
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
To:     Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
 <20201212205522.GF2443@casper.infradead.org>
 <877dpln5uf.fsf@x220.int.ebiederm.org>
 <20201213162941.GG2443@casper.infradead.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b18f4448-d31f-c4a7-ffea-e4cf2587b78b@schaufler-ca.com>
Date:   Mon, 14 Dec 2020 10:45:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201213162941.GG2443@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17278 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/13/2020 8:29 AM, Matthew Wilcox wrote:
> On Sun, Dec 13, 2020 at 08:22:32AM -0600, Eric W. Biederman wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>>> On Thu, Dec 03, 2020 at 04:02:12PM -0800, Stephen Brennan wrote:
>>>> -void pid_update_inode(struct task_struct *task, struct inode *inode)
>>>> +static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
>>>> +			       unsigned int flags)
>>> I'm really nitpicking here, but this function only _updates_ the inode
>>> if flags says it should.  So I was thinking something like this
>>> (compile tested only).
>>>
>>> I'd really appreocate feedback from someone like Casey or Stephen on
>>> what they need for their security modules.
>> Just so we don't have security module questions confusing things
>> can we please make this a 2 patch series?  With the first
>> patch removing security_task_to_inode?
>>
>> The justification for the removal is that all security_task_to_inode
>> appears to care about is the file type bits in inode->i_mode.  Something
>> that never changes.  Having this in a separate patch would make that
>> logical change easier to verify.
> I don't think that's right, which is why I keep asking Stephen & Casey
> for their thoughts.  For example,
>
>  * Sets the smack pointer in the inode security blob
>  */
> static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
> {
>         struct inode_smack *isp = smack_inode(inode);
>         struct smack_known *skp = smk_of_task_struct(p);
>
>         isp->smk_inode = skp;
>         isp->smk_flags |= SMK_INODE_INSTANT;
> }
>
> That seems to do rather more than checking the file type bits.

I'm going to have to bring myself up to speed on the
discussion before I say anything dumb. I'm supposed to
be Not! Working! today. I will get on it as permitted.

