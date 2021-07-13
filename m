Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562673C722A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbhGMObe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 10:31:34 -0400
Received: from sonic308-14.consmr.mail.ne1.yahoo.com ([66.163.187.37]:40499
        "EHLO sonic308-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236757AbhGMObe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 10:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626186524; bh=18BmMZkvH2tBvb+UvZGjk8mOAMpg1SXeFmAfTWxjld4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=ArUFeu3bkk7ikJdPTPJueCjsUsNpbGnjxSwelS9i7L/DrB4KXJUz/dqYE4JNW35+D6XK3AzgXY+0g7f7ArO3au+2ICbCxgoNRLuXQLxKmL6iScdccq84epNmKjLHIqZoaKGzgQW36CUMZ8oCPA4U5xEOtBiQPsNg2qe0Ny3GuKelz5R+eliIXOzLmYf+FYxxW5ZnBbPi+3idbcFMVhwK+YSharzRMuBkrtBFzRtXZmPpzyPrueYtkB9smlRaWVuyMTpUor75bkva50w4v2TcSVperlwbVoqsHW79Hanqeqa5J9W20jJ5WqJGgkAs4g0Ef/JkdmLtvTUz6e0eEBtniQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626186524; bh=j3tFSHKLFo40tIKO5gPl4ZZ91xtSXbDy2j9mtTOrboP=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=GsnTiNKqjtE98dUWkrt2NEpTX4mDJsjL/CiwEkNbUWAEAFS+umgM5BhJyej5xarrnN00/RIXb3B88ziecXBOQ1iqAGtxax2ks9f1kMpqFtpQmUE9UPbmwmtdbVcEdqEcj0DYJN2+7ytDhc6dYTgSCBTrlj+3d+hparrOEKkQwqRDez+WnQUCa70f8RnU0zaxdPeit9E2jrsuxi3fXgFRKsqdnmQuEFB3V8hSYphp+E1qmj6p1yVrD2UmXSyWgI9jWT7GmUMlZz+cWN0s06oKh3ECAfjuIOvZSimd0qCZgRZ2vvhyTWGvY8/3ppNF3weUXH0Uh6XR+sLc6PJDanhe3g==
X-YMail-OSG: 19SWruUVM1m4X.taiD7Xf0lhV_qfh0BPVbtnr0_MlTlwNusH.C6ayqqU6UbtfeE
 F7RpVgEmS9cJDJFEMd.TBt2dhfx6AUn2fhFPsSSrCuRw8l7XxwrTQvnGL0yw5p0Zc81C20WRcfl3
 CWQlxgNsjHyVmJ7IFOJwo2H.65TuP4DF_erhcWaNd8gj6MJJSTxkSS9kfIA7ptz5mAqTRCjhI6Xy
 AzxA8OThnqQoIAVHFAK3qpC7sqC0ri.GGGDqvSvYbrCr27dlK72i9VndIMJlT6W.OrXMvBrzi6Fm
 7Yq.Ck9fKR3P8Bczbs3l3m7EyynzBw8IMcVBPXv3rfgAPTK0.RcFk07YjEazx971vBpya70M_dUC
 Yjc9JwfKgtUZUCCOjQx6vTKmd..PSv0f_q8jH3NfVbx0mFvsX72HcrglomXmFtaE2JW0Rth92ljA
 mxw8Dmv.eUlREwUWg7m35xbkkSzFp9Guf0fyQwQaTClh8NkUgIXhxCRPS26S_P5lh2q2g76Jyx2M
 1h9DqxFmMkF3f0oI6L3rLlu2wvpMIbc3kGk0OlTzpnMnNcD87up8b9ByksVC_y5ygifOHB_5LTMh
 ZFT4JxiyYm7dYUcnyOv8xtSeSyBPF_9wmgHAIJpyyFzwgnK6fgejhk5lS_CsD06avov5Yv5B5eo7
 IOpgrERI3v13aASzxI.Dt1s23fI_azr3.8ejY777VcqhCBzDyPcPc6EoIlJLBXMNuVEq.ZJEZIEi
 PNLV_aitQAW43k4zeDQt4aAyEVyuHTmLYUItfrJLxhIvVdLAp_K0nw12jc.L5w37RfttK0ZnfjW_
 Fkys6YpieRvz_mn_xsAsosfVzmj9viCC6m93VUOIbq20LFziE4vj.puqzQfr7a.8CBfOyCsrhKB2
 FGU9u2BnAS0pLKX6vth8L28Mvu6IC5J9HQzlusTkL6y7lgnWhNRLfiW9ARv.S9ehZ81olCAM0SyL
 .eHYUOBteXY5jQO3UQhXetBO6bTR5V_7zbQWDXOSQVyuYGx1j_2OGY47BCPihPqaMso0dZXQvJcF
 Mdu5JeQCq8senDEZ2rK1rBJgfUwY.VopNhrL55ISFSaggGHm40ybBVN4.v.6shbA941EwCL94Dfn
 kpm2BMYnM6vPSrVQAix8biC3J0wIkkE0.hYd4svqwMEQdXKBBZ3UiMcnZBDkANHDvIYOEhvaV61c
 pEapMO7KxwqPTI4hkGNYSKV3faX5PtgkiEOMT_UdoBpRsmZkP0ni8B0oMNTCfQQ3DQP9CxUMWh.7
 X7rSFTFgfgWnrSiJOiLJNoPLomOz9hIMv14C2fS7JpHRIUB1bKSQJSGG9CfZRtX0RDh6xEh.Ey97
 z4AWw_1wEiX0nQSyCaKL94DoHPukqwhmVknWtkBG7CH81aFc90s_9irIYqfP_beFMl0mfWUqzYAQ
 KSU0GO5b8P4hKUA3RKzlZevryeqaW6p4yvuawhQVKNaIbHxrE38oqacIS596bKl8jYX7qk8xzgsZ
 xGtV.g6a0yjg.FmgbIVXxluUeVzEauCzmAyMaYACtydcgZpY53SNfbWLREeHA8xRH5hPM9Gnvyvv
 2pWZWpN7P2lKlPJBQ47NcFH1B23k01MEfkm5lgz7jjLue2Pglm__bPxOx.QRkazeJNiV6qOLpyXA
 EadBfEPo0YqtJb45tl9bLTL6MiqjMdWwn1d64_KwJ0Xw9udo3jY2TvBT3OFNdTFE43exNznkPi5i
 T2eCcM5Tpjnh6vwg2.AjzggSDpAY6nIc_sZorP8MJQyn29EoB2qqsNasF67CfYUD4BOz_yiLi.zh
 nJZWFJ0x.oU27Exkv9xMkC9ojrJpYgZR1KOn6vslXov1k9Mdb.7CsXTrOHYdtH_fjYPXrRW1qAz2
 np44GsTnr5VGQZSI5cluHiBZOXhQo35swS92eRMe51FCVMP74bagVHxSg9RbAwuO7MOyCQVb_MF3
 OBNpto1v_rKABfxQ1dEBvEpOLx4eC74.RHmTfNmIsvGTQ1vpa93o82BB_mVruP9NBP_783NZdAYL
 E5RApal2B9g5lMtBc81iPGBLbM7taBz7uE9q4jm6hzsNGDkufWMlsN8dI13VHL0PUOXtd5yY_QFg
 .q7fpUISxsy9Du7nQF2.usvqo6_TxKdFom0qGX9CCIPJm.OFBmh9vYwcqjgeBgVPxemkKhfm6Jfz
 aYBjaFI2fSISYxkAWzRE9RIJsOAH.lAFSODjXBjg6CYVQbdz7ZdjpTJxxFUjaz1w8W3.bYsvvoaN
 Pq3DMm25T4DUJf5Yp13D.Ekz9p9eItVnTFhS7OyXVoKafsOY2Ov0kz7Zlg2otRGkXcEzaM5_5UxR
 bEMVFxu373lDJsSnz3RITxE6iBJiv.IBrlW6lHWAcdor4ZLPgZvSS.K3bMRLmEqSg0m6SdGgVKUB
 YYQIoEix7BpLRCX9pbXfFnxoyBJdb4ibtvUBJVlT76BB6o6SsO7Npfkd2fPrF7WMLKdHV4eXqAwg
 I.Q66mCta5HdnnuiidorGiIsxCWkqH3MAjyP3jIzTLKXMlSwHKviWO8VS_l2knzFp6t1t44Yn58g
 9.2UXgh5dko9ZXwGgMfqEEv3_jVBVL4PbyuLmEugxQNlZaJshuJlQQRl2Y74Bb4IUCRU76Uihn_x
 PY9lw.7G7BAe8v.AIxqzRizeL00ZYP2XYU2PJHoV5d7ZbyCHkU0Oa4f0tS7ktx97ckiZtlsAYMT6
 lUr23OTd8GdIIUlld2SP_yEdFwygspQR6Z0D34UnNWy4_RYMNyPXvujZHyt4BVgSh681zkRni8lO
 F9xRYJMa1uEB8lmaDYmDtqzMZ__AWcaf8HQQbU5I7H1S8cUdX1HOC1L9GsnRFZshh5vWSBP6j8Me
 nTwDtq.5FXwY21jfOc4lv6GyfZURLNef4iuG.N6dZrbS6xan5AjJrAlDqpW1Iy2iaS9sUCiGBjfZ
 t4WOjFhWZRFrhVX09Ue9ksqgiZI0T3Zx2mMd3yW1BQI6cEAfre4y8paN9PEWXOov3kRLBgXkwDPj
 2QV7UGRsLGSB99mCj4i0bB8XN3CMxAXgllST5ZSqgXrBYa1dHoaKyVUctJHp8Cda1VTVKi7ikFIS
 sN2L8ROSYgZN0YnQZQ4c0uiIu10faz2uM9oS2wLMKMLKundpTdHPVqKPz_RlmeNpAKjPTN.dUxXF
 0dPyMTo2preTy5mD_.eYeGYBYxbSKwRwJXJRneYCYN1hPreuNyejbWlXKnY8bGA_ICA8H4bwwYIq
 bxN3aUtt.XSilNh7MaSydXjqOoMMGL2WCYkmRs7MjFix3ZUA.OFReE3py8ooLR0rbU6nXb_24k5x
 gxaUByUJ3kEPFtfHocm2qekG3HgmeVYRva6pZGj.hBOb5KhGoGhVXEBVFFOaeW7AbKQXIMiDjd3h
 OZ84GRVKdk0UZW3kNbgqkG5Af6wCRdT6Xl7Flq2j5fEZUrUe6QJrPkdlXZ_yCKxmSIEdqRvhIx4T
 tPJQw65d.k5BaTbfrG.dB1WWrjSv36UaA8LuNnc7Pgmf3CbwFyK30FcEcL5X3ujb_5a0wULBQ0gi
 xgQbvLn0Y4roma4DjaT0_SmUUvbqfFYza
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jul 2021 14:28:44 +0000
Received: by kubenode518.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 59e6becde9cf1fc6afb901009309f8fb;
          Tue, 13 Jul 2021 14:28:39 +0000 (UTC)
Subject: Re: [Virtio-fs] [PATCH v2 1/1] xattr: Allow user.* xattr on symlink
 and special files
To:     Greg Kurz <groug@kaod.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        gscrivan@redhat.com, tytso@mit.edu, miklos@szeredi.hu,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, jack@suse.cz,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
 <20210712144849.121c948c@bahia.lan>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cea2f545-ab2d-e9a8-0258-9c8bb443784f@schaufler-ca.com>
Date:   Tue, 13 Jul 2021 07:28:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210712144849.121c948c@bahia.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/12/2021 5:49 AM, Greg Kurz wrote:
> On Fri, 9 Jul 2021 08:34:41 -0700
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>> On 7/9/2021 8:27 AM, Vivek Goyal wrote:
>>> On Fri, Jul 09, 2021 at 11:19:15AM +0200, Christian Brauner wrote:
>>>> On Thu, Jul 08, 2021 at 01:57:38PM -0400, Vivek Goyal wrote:
>>>>> Currently user.* xattr are not allowed on symlink and special files.
>>>>>
>>>>> man xattr and recent discussion suggested that primary reason for this
>>>>> restriction is how file permissions for symlinks and special files
>>>>> are little different from regular files and directories.
>>>>>
>>>>> For symlinks, they are world readable/writable and if user xattr were
>>>>> to be permitted, it will allow unpriviliged users to dump a huge amount
>>>>> of user.* xattrs on symlinks without any control.
>>>>>
>>>>> For special files, permissions typically control capability to read/write
>>>>> from devices (and not necessarily from filesystem). So if a user can
>>>>> write to device (/dev/null), does not necessarily mean it should be allowed
>>>>> to write large number of user.* xattrs on the filesystem device node is
>>>>> residing in.
>>>>>
>>>>> This patch proposes to relax the restrictions a bit and allow file owner
>>>>> or priviliged user (CAP_FOWNER), to be able to read/write user.* xattrs
>>>>> on symlink and special files.
>>>>>
>>>>> virtiofs daemon has a need to store user.* xatrrs on all the files
>>>>> (including symlinks and special files), and currently that fails. This
>>>>> patch should help.
>>>>>
>>>>> Link: https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
>>>>> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>>>>> ---
>>>> Seems reasonable and useful.
>>>> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>>>>
>>>> One question, do all filesystem supporting xattrs deal with setting them
>>>> on symlinks/device files correctly?
>>> Wrote a simple bash script to do setfattr/getfattr user.foo xattr on
>>> symlink and device node on ext4, xfs and btrfs and it works fine.
>> How about nfs, tmpfs, overlayfs and/or some of the other less conventional
>> filesystems?
>>
> How about virtiofs then ? :-)

One of the "less conventional filesystems", surely.
�

