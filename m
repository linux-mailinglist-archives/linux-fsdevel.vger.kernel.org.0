Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F901E4A8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 18:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbgE0Qlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 12:41:31 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:42116
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729686AbgE0Qla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 12:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590597689; bh=WFz2psKHCfQhmvtHPrIqBJFxV5x1yMU8wLknvksbfFM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=VD4+c/WpVzlruHaW5np7TGoKLUdDWnPfRhfTk0obj3AVdoaEFxtYzwW1fdTmOpqQyYYjep26kiRR7/Xy+BKwSKV7tnMpIkUn/z7Wxsd1yujmf4llsizwQCVVrpxN/tthF6evcubQbN7cI3mJLa87T4OfjDm+GztWTpuMCRVkVuKN85imNynIUk8965dVR+Zc3IofaKhLweUjAlxAowVIYUH9AHKvi+0hgk0NhjE/HjcchzYZa0EXGBTBud/nbap35Ndx97UpRc/4FuP3Pkb9ucW2x7dmAX4VrGF3Bdkd4ZW8bTw3dVa4geKxF1vN31+VBGK4CkVfp6rGF+Z7jcv2Xg==
X-YMail-OSG: 9u6BTg0VM1lMkijTQSIzP5WDh2TdWCnf_YcdA9GomtFLkBiK2ISamQRwEK8hmLD
 L4b6dET2gJW98QlYlV.4s.hiy_IO3ctnrXltFOmpCp3QTV1taYlY.UmLOB07DwrBlPPNLRsHBhkz
 XZzZRL1bWWhTVITf55rODQDT3Wut0Sok6hrLQAbKpwgPDC1K4dbZPv1oa6rdxS4ua8p1V3B3xOw_
 8RQr_eFE8N9QjAUPwU6BI4wzV...U.ICd0YL.lxYvnXqFHSKeQW_1LaPV5LiciJm6ghSNSYqsQz5
 2kxrL5pQAPeI4Hhzap7MEU9xAY5tOEP07TmKzXYaeFczvHnxXW0r1BpJxK83mpkHsErzlVZ22AKQ
 O4LTS9THgZsrUPgZGtEXoBkoltkfsDD4jfLyPWk.BypRBFj2VlNB8EVnaVxrwbBUBP7Of_N7QwEz
 5ujEwfhvRJ2z8zTlZFZ0yjKx_fF7vL7_ovkKMPmQB87Ty41OmU.ONq9AY7XroRMmnN6j0G3QjxbJ
 1a82STOjNVWhQI7aA65R81264GkfHtBvcDOicYXxZhhi78gPkyiKvT4RGmqROJDGIt.58t0ZTUaw
 KZQpsDkloSRxoZaEHYKBlm5u3A7GPnZIewBxfpIf73LIAGqXarRkwMnrQRNOi.9QQEZb8KS_CTNg
 bDiWDN3t54Bnjrx6cpQnV9pFNVMdmD3tygPHAP8QJz_mo7_GmWo2HHNFecmsK.qa7jYVTcNU1MwR
 3GmJ0AJ4vObe7I0Z0OmpWuk.ujxpzMF_LQuFk.PgRJdFLyuMMK7gbEFLhuBZICB8RxqABpjzSJdK
 xFwPDyG_Y6srXxLwz1xwAKT2qa867mlMpqBJ7L4ZGXF.ruD2Frxdbs4w0tiDJhnHwLVff4eDAd5Z
 maLWnWK0avuyGd.He30MyvFSEXTpwIaUDiVVzyAkxAgf1hMBeqjAEuyttBC0HVA37KAWMmewDVJy
 tXmQu_Bkqqsoc8TFW3arf0bMhItHWEha5M8TzAQGjZXc9rU8WZYMoOwymWwTyGdk6rp0.veWK0gq
 oWvbqmBh7TBUm7MLCWyBOm8RuDIpRVfdZ8e7clw5ZUr5bPJ3epvBnKns65p6cJ4qZnk64j0X45Z0
 GKNF6LA.ZGj1nL4DClLXW6f37D93IC8YJ1VdeS_isEl_VXJmxh4j7.fNuiI1QQsqYP9La.91wuGj
 q265ZqfUGG.N3pa3Nk3CNjuKfzU.fWuw8PRukMWJM5eQvtiCch0rBf5D.CMh5QjnGEM0gPhTMF_y
 RFs2TGDjnMRsKz1fp0aQNC38Q9MonIzc1XtvDQZ0RywjNgDInTtE7uHPNfs7Sor0k_qeelE24TXe
 2Wf6azcstzuMjO2tmwQA44QicJzgYdBPP8O0kni8_qDpFvF81g0HEnmpwGmc_FpomTz2ideLLolk
 eAjWcQAZ2H.6csdexi912yeuGbD7hpO4su8P_Ij14asc0i6IF6Qcu.57FoedNpQBBLfL8Ot8seFR
 .OBS0iUE4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 May 2020 16:41:29 +0000
Received: by smtp426.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0a021d393f0279ac5d0e653381de71d2;
          Wed, 27 May 2020 16:41:26 +0000 (UTC)
Subject: Re: [PATCH bpf-next 2/4] bpf: Implement bpf_local_storage for inodes
To:     KP Singh <kpsingh@chromium.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200526163336.63653-1-kpsingh@chromium.org>
 <20200526163336.63653-3-kpsingh@chromium.org>
 <20200527050823.GA31860@infradead.org> <20200527123840.GA12958@google.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <f933521f-6370-c9ba-d662-703c1ebc7c03@schaufler-ca.com>
Date:   Wed, 27 May 2020 09:41:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527123840.GA12958@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15959 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/27/2020 5:38 AM, KP Singh wrote:
> On 26-May 22:08, Christoph Hellwig wrote:
>> On Tue, May 26, 2020 at 06:33:34PM +0200, KP Singh wrote:
>>> From: KP Singh <kpsingh@google.com>
>>>
>>> Similar to bpf_local_storage for sockets, add local storage for inode=
s.
>>> The life-cycle of storage is managed with the life-cycle of the inode=
=2E
>>> i.e. the storage is destroyed along with the owning inode.
>>>
>>> Since, the intention is to use this in LSM programs, the destruction =
is
>>> done after security_inode_free in __destroy_inode.
>> NAK onbloating the inode structure.  Please find an out of line way
>> to store your information.
> The other alternative is to use lbs_inode (security blobs) and we can
> do this without adding fields to struct inode.

This is the correct approach, and always has been. This isn't the
first ( or second :( ) case where the correct behavior for an LSM
has been pretty darn obvious, but you've taken a different approach
for no apparent reason.

> Here is a rough diff (only illustrative, won't apply cleanly) of the
> changes needed to this patch:
>
>  https://gist.github.com/sinkap/1d213d17fb82a5e8ffdc3f320ec37d79

To do just a little nit-picking, please use bpf_inode() instead of
bpf_inode_storage(). This is in keeping with the convention used by
the other security modules. Sticking with the existing convention
makes it easier for people (and tools) that work with multiple
security modules.

> Once tracing has gets a whitelist based access to inode storage, I
> guess it, too, can use bpf_local_storage for inodes

Only within the BPF module. Your sentence above is slightly garbled,
so I'm not really sure what you're saying, but if you're suggesting
that tracing code outside of the BPF security module can use the
BPF inode data, the answer is a resounding "no".

>  if CONFIG_BPF_LSM
> is enabled. Does this sound reasonable to the BPF folks?
>
> - KP
>
>

