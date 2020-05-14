Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BFB1D371C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgENQ4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 12:56:52 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:34938
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgENQ4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 12:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589475406; bh=VePP3AlCwJg2EGO8jXY+WnQEJRNt7KiDPu2EU0qafGE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=a2QXbLrBAzG7aupD9Sma6DrFN+iYGRPqrttHtwtIW0rxSUfgKSotGYhOQyHF12TB//sRylkfSGVW4dvSW4BZFz/HVuriWTwqokTeICHARZG3TExcLQCooQWt7fMPO3KozoFeMbqUtmixxKbUZcG5uSXQARV9Ghf3ijkw4nEhsB64dU9Xg5OOC3y85oq4CbgJLLGbK9PJ5T2nKl2MWXAA7VCaEkmZYsp/xNgtZlU99CW3heAjE92BrUO7AQinqbclGEZeameS4l0XGs8mzJmu81g5sU2kuMCqz9vxO3ezFi0VVBwhHafe6k2PlP0Gd8qyr9lG8GfxLU9gtYdpkQYozw==
X-YMail-OSG: Dtwa1ykVM1m_YbIOhcWQsOljD.NCOwBhPkSuUU8M5pdiRqij7nc9jVKJ87y1rlb
 tsMtLoRagRXXApA1_DqRhtE63yXMoDEIQb_fP7w7LXd10skMzAXQ.x5QvrDYG5aup0i6LBHCdhix
 QWZK5Vwp.fJdsEqDc3VvQI.cB7qdm_6TFmqAZISniOohKcnhBGMlTe_Pnhi5o63xknzJt9QNcpoR
 tgH94r4dOP_XV7L79LMKhJajG6zUz5oqkBWManvdSfRtjQcGos.hedRXGYbyrPdCLE7lFCGiSNCQ
 X.IzwjZ1CBiHYZTJYAnjN7p.DYAZ7OXQLwLA8Y_YFUB3ikDy9mfon5Br3mY_byB3gN47UgC9axH6
 Zk1AHFImqRLbIH3IpzwXI8GybuKW2X_2rzf65HGeUExDurOEtIrQw0YHcG_lx3npPgTQj.2vUT6y
 s9iz6szDsSg9LMhG6dRpTs5wZbaLqn7xjVv2oho_2jT0k0VJye8ZNueM7tb2J4cNvFZWwaJmBbnZ
 cO1WQmybqDEiMtTTO7E1jPqbUCJqar71nMp02RTkRYW79MtxyfMugH1tfJhaSRmFk5tibmuPe6vM
 noj9QcPq6D52gCE4yVYNbLhapSsyNf7pl95WzwseGZWJyMChjJqyubCYxNweLBeo19WaYIPHs.tj
 1nvCz6d627Pf_N6A5EBxOdfC6lvHdOnBj8EbSa.3GA7p8xJQpDz.EPv9lYd_pNqzZPCi6U9RGNbJ
 kyMni9YZONKDJNylY2WPud5B2WdzIe1wG3VIBT03jOre8UWCudZiEyaUnvWXzfR0dr5DxS2abMdL
 ZTxZxufKK3DbE62gMLhmiL5jWhP1_iVSJrSWUiMr03a_ckMoFSOYCi3nnwNCeFhfZiMkgnI_7pfg
 LGmEWixvo.dThwEJaugVaf9BheIp291L_A8zKpUEMrEfr55HUzFgP0fbe2TqXUZ9umh7nASPHksj
 ZRbFcCoV1KPcTDjzGH4v.CrncVFMCR0cF7X3CkcjW6XYgqS.qZ51hGStJFFXLb.gyWhngeNy.LPB
 FGBykCGwpJlPODHxpxMBANar7PFLnIXn0htucMoRI9cF3ONAPvx9dM8j.vlSMt54pjFycCMapwly
 97_YwJg8rXwcDsD4_4NmwuCNWJ5U.K1jbc5yFCpiUF.uXYceW6Mhn354LVgVVE1MDcnQlj1LlF4J
 vLNwZl84z8VLJjQy8hwy1UOc2hP6Z2TUNlKC8uekppssUivrofKLcJ_V4G.8_o8xpzY1qbWT_r4y
 QEKv5mI2SvNet9qTQ.uqf8bNZs18LJ7..Ewef3y_qCE1.3YNSx_tW83wodI5RXUAGbnBSet3UDHZ
 iGwY3M3jTVY3ce9uViIDFwC4lWFaf0_2qi5sNXrWC2L0u2ZNxOhNRi6lFPnXRugkjp_BZYbgDcW8
 p3ps0h_nhZPOYLFUnwFbBl2MqihVEvyM2efVVp7lIWpSQbYY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2020 16:56:46 +0000
Received: by smtp414.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID cdcbb12f8b30853379a6f99b595cefe7;
          Thu, 14 May 2020 16:56:44 +0000 (UTC)
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org> <202005111428.B094E3B76A@keescook>
 <874kslq9jm.fsf@x220.int.ebiederm.org> <202005121218.ED0B728DA@keescook>
 <87lflwq4hu.fsf@x220.int.ebiederm.org> <202005121606.5575978B@keescook>
 <202005121625.20B35A3@keescook> <202005121649.4ED677068@keescook>
 <87sgg2ftuj.fsf@x220.int.ebiederm.org>
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
Message-ID: <a2169b6f-b527-7e35-2d41-1e9cd1f8436c@schaufler-ca.com>
Date:   Thu, 14 May 2020 09:56:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87sgg2ftuj.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15941 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/14/2020 7:56 AM, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> On Tue, May 12, 2020 at 04:47:14PM -0700, Kees Cook wrote:
>>> And now I wonder if qemu actually uses the resulting AT_EXECFD ...
>> It does, though I'm not sure if this is to support crossing mount poin=
ts,
>> dropping privileges, or something else, since it does fall back to jus=
t
>> trying to open the file.
>>
>>     execfd =3D qemu_getauxval(AT_EXECFD);
>>     if (execfd =3D=3D 0) {
>>         execfd =3D open(filename, O_RDONLY);
>>         if (execfd < 0) {
>>             printf("Error while loading %s: %s\n", filename, strerror(=
errno));
>>             _exit(EXIT_FAILURE);
>>         }
>>     }
> My hunch is that the fallback exists from a time when the kernel did no=
t
> implement AT_EXECFD, or so that qemu can run on kernels that don't
> implement AT_EXECFD.  It doesn't really matter unless the executable is=

> suid, or otherwise changes privileges.
>
>
> I looked into this a bit to remind myself why exec works the way it
> works, with changing privileges.
>
> The classic attack is pointing a symlink at a #! script that is suid or=

> otherwise changes privileges.  The kernel will open the script and set
> the privileges, read the interpreter from the first line, and proceed t=
o
> exec the interpreter.  The interpreter will then open the script using
> the pathname supplied by the kernel.  The name of the symlink.
> Before the interpreter reopens the script the attack would replace
> the symlink with a script that does something else, but gets to run
> with the privileges of the script.
>
>
> Defending against that time of check vs time of use attack is why
> bprm_fill_uid, and cap_bprm_set_creds use the credentials derived from
> the interpreter instead of the credentials derived from the script.
>
>
> The other defense is to replace the pathname of the executable that the=

> intepreter will open with /dev/fd/N.
>
> All of this predates Linux entirely.  I do remember this was fixed at
> some point in Linux but I don't remember the details.  I can just read
> the solution that was picked in the code.
>
>
>
> All of this makes me wonder how are the LSMs protected against this
> attack.
>
> Let's see the following LSMS implement brpm_set_creds:
> tomoyo   - Abuses bprm_set_creds to call tomoyo_load_policy [ safe ]
> smack    - Requires CAP_MAC_ADMIN to smack setxattrs        [ vulnerabl=
e? ]
>            Uses those xattrs in smack_bprm_set_creds

What is the concern? If the xattrs change after the check,
the behavior should still be consistent.=20

> apparmor - Everything is based on names so the symlink      [ safe? ]
>            attack won't work as it has the wrong name.
>            As long as the trusted names can't be renamed
>            apparmor appears good.
> selinux  - Appears to let anyone set selinux xattrs         [ safe? ]
>            Requires permission for a sid transfer
>            As the attack appears not to allow anything that
>            would not be allowed anyway it looks like selinux
>            is safe.
>
> LSM folks, especially Casey am I reading this correctly?  Did I
> correctly infer how your LSMs deal with the time of check to time of us=
e
> attack on the script name?
>
> Eric
>

